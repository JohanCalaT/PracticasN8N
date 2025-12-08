# worker/worker.py
import os
import pika
import json
import time
import sys

def main():
    rabbitmq_url = os.environ.get('RABBITMQ_URL')
    connection = None

    # Bucle para reintentar la conexión si RabbitMQ no está listo
    while not connection:
        try:
            connection = pika.BlockingConnection(pika.URLParameters(rabbitmq_url))
            print("Worker: Conectado a RabbitMQ.")
        except pika.exceptions.AMQPConnectionError:
            print("Worker: Esperando a RabbitMQ...")
            time.sleep(5)

    channel = connection.channel()

    # Declarar ambas colas
    channel.queue_declare(queue='task_created', durable=True)
    channel.queue_declare(queue='task_completed', durable=True)

    # Callback para procesar mensajes de task_created
    def callback_created(ch, method, properties, body):
        try:
            task_data = json.loads(body)
            print(f" [x] 📝 Nueva tarea creada: ID={task_data.get('id')}, Título='{task_data.get('title')}'")
            # Aquí iría la lógica de procesamiento adicional
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as e:
            print(f" [!] Error procesando mensaje: {e}")
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    # Callback para procesar mensajes de task_completed (EJERCICIO 1)
    def callback_completed(ch, method, properties, body):
        try:
            task_data = json.loads(body)
            print(f" [+] ✅ Tarea completada: ID={task_data.get('id')}, Título='{task_data.get('title')}'")
            # Aquí iría la lógica de procesamiento adicional
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as e:
            print(f" [!] Error procesando mensaje completado: {e}")
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    # Configurar prefetch para procesar un mensaje a la vez
    channel.basic_qos(prefetch_count=1)

    # Suscribirse a ambas colas
    channel.basic_consume(queue='task_created', on_message_callback=callback_created)
    channel.basic_consume(queue='task_completed', on_message_callback=callback_completed)

    print(' [*] Worker esperando mensajes. Para salir presione CTRL+C')
    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('\nWorker interrumpido')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)