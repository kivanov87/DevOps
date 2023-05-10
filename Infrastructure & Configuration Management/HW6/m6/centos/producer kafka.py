from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers=['192.168.33.10:9092'])

producer.send('my_topic', b'Custom message 1')
producer.send('my_topic', b'Custom message 2')
producer.send('my_topic', b'Custom message 3')

producer.flush()
