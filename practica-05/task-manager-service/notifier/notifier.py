# notifier/notifier.py
import os
import pika
import json
import time
import sys
import requests

def main():
    rabbitmq_url = os.environ.get('RABBITMQ_URL')
    webhook_url = os.environ.get('WEBHOOK_URL', 'https://webhook.site/your-unique-url')
    connection = None

    # Bucle para reintentar la conexión
    while not connection:
        try:
            connection = pika.BlockingConnection(pika.URLParameters(rabbitmq_url))
            print("Notifier: Conectado a RabbitMQ.")
        except pika.exceptions.AMQPConnectionError:
            print("Notifier: Esperando a RabbitMQ...")
            time.sleep(5)

    channel = connection.channel()
    channel.queue_declare(queue='task_completed', durable=True)

    def callback(ch, method, properties, body):
        try:
            task_data = json.loads(body)
            print(f" [📧] Enviando notificación para tarea: ID={task_data.get('id')}")
            
            # Simular envío de email mediante webhook
            notification_data = {
                'type': 'task_completed',
                'task_id': task_data.get('id'),
                'task_title': task_data.get('title'),
                'message': f"La tarea '{task_data.get('title')}' ha sido completada."
            }
            
            # Enviar a webhook.site (o cualquier otro servicio)
            try:
                response = requests.post(webhook_url, json=notification_data, timeout=5)
                if response.status_code == 200:
                    print(f" [✓] Notificación enviada exitosamente")
                else:
                    print(f" [!] Error al enviar notificación: {response.status_code}")
            except requests.exceptions.RequestException as e:
                print(f" [!] Error de conexión al enviar notificación: {e}")
            
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as e:
            print(f" [!] Error procesando mensaje: {e}")
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(queue='task_completed', on_message_callback=callback)

    print(' [*] Notifier esperando mensajes de tareas completadas...')
    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('\nNotifier interrumpido')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
