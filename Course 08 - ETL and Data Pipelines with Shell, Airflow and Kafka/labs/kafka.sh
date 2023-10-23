bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties

bin/kafka-topics.sh --create --topic news --bootstrap-server localhost:9092

bin/kafka-console-producer.sh --topic news --bootstrap-server localhost:9092

bin/kafka-console-consumer.sh --topic news --from-beginning --bootstrap-server localhost:9092


# Consumer Offset
# Topic partitions keeps published messages in a sequence, like a list.
# Message offset indicates a message’s position in the sequence. For example,
# the offset of an empty Partition 0 of bankbranch is 0, and if you publish the first message
# to the partition, its offset will be 1.

# By using offsets in the consumer, you can specify the starting position for message consumption, such as from the beginning to retrieve all messages, or from some later point to retrieve only the latest messages.

# Consumer Group
# In addition, we normally group related consumers together as a consumer group.
# For example, we may want to create a consumer for each ATM in the bank and manage all ATM related consumers
# together in a group.

# So let’s see how to create a consumer group, which is actually very easy with the --group argument.

# In the consumer terminal, stop the previous consumer if it is still running.

# Run the following command to create a new consumer within a consumer group called atm-app:


bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app

# Reset offset
# We can reset the index with the --reset-offsets argument.

# First let’s try resetting the offset to the earliest position (beginning) using --reset-offsets --to-earliest.

# Stop the previous consumer if it is still running, and run the following command to reset the offset:

bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092  --topic bankbranch --group atm-app --reset-offsets --to-earliest --execute

# Now the offsets have been set to 0 (the beginning).

# Start the consumer again:
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app

# You should see that all 12 messages are consumed and that all offsets have reached the partition ends again.

# In fact, you can reset the offset to any position. For example, let’s reset the offset so that
# we only consume the last two messages.

# Stop the previous consumer

# Shift the offset to left by 2 using --reset-offsets --shift-by -2:


bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092  --topic bankbranch --group atm-app --reset-offsets --shift-by -2 --execute
Copied!
# If you run the consumer again, you should see that we consumed 4 messages, 2 for each partition:

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app



