# error-handler/error_handler.py
import os
import pika
import json
import time
import sys
from datetime import datetime

def main():
    rabbitmq_url = os.environ.get('RABBITMQ_URL')
    connection = None

    while not connection:
        try:
            connection = pika.BlockingConnection(pika.URLParameters(rabbitmq_url))
            print("Error Handler: Conectado a RabbitMQ.")
        except pika.exceptions.AMQPConnectionError:
            print("Error Handler: Esperando a RabbitMQ...")
            time.sleep(5)

    channel = connection.channel()
    channel.queue_declare(queue='tasks_failed', durable=True)

    def callback(ch, method, properties, body):
        try:
            task_data = json.loads(body)
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            
            # Registrar en un archivo de log
            log_entry = f"[{timestamp}] FAILED TASK: {json.dumps(task_data)}\n"
            
            with open('/app/logs/failed_tasks.log', 'a') as f:
                f.write(log_entry)
            
            print(f" [⚠️] Tarea fallida registrada: {task_data}")
            ch.basic_ack(delivery_tag=method.delivery_tag)
            
        except Exception as e:
            print(f" [!] Error procesando mensaje fallido: {e}")
            ch.basic_ack(delivery_tag=method.delivery_tag)

    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(queue='tasks_failed', on_message_callback=callback)

    print(' [*] Error Handler esperando mensajes fallidos...')
    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('\nError Handler interrumpido')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
