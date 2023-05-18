.PHONY: clean rabbit2 rabbit3 rabbit4

clean:
	rm -rf /tmp/rabbitmq-test-instances/*

cluster: rabbit2 rabbit3 rabbit4

rabbit2:
	$(MAKE) -C "$(HOME)/development/rabbitmq/rabbitmq-server" \
		RABBITMQ_NODENAME='rabbit2@shostakovich2' \
		RABBITMQ_NODE_IP_ADDRESS='127.0.0.2' \
		RABBITMQ_DIST_PORT=25672 \
		RABBITMQ_CONFIG_FILE="$(CURDIR)/rabbit2.conf" \
		PLUGINS='rabbitmq_management rabbitmq_top' \
		RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS='-kernel inet_dist_use_interface {127,0,0,2} -kernel net_ticktime 5' run-broker

rabbit3:
	$(MAKE) -C "$(HOME)/development/rabbitmq/rabbitmq-server" \
		RABBITMQ_NODENAME='rabbit3@shostakovich3' \
		RABBITMQ_NODE_IP_ADDRESS='127.0.0.3' \
		RABBITMQ_DIST_PORT=25673 \
		RABBITMQ_CONFIG_FILE="$(CURDIR)/rabbit3.conf" \
		PLUGINS='rabbitmq_management rabbitmq_top' \
		RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS='-kernel inet_dist_use_interface {127,0,0,3} -kernel net_ticktime 5' run-broker

rabbit4:
	$(MAKE) -C "$(HOME)/development/rabbitmq/rabbitmq-server" \
		RABBITMQ_NODENAME='rabbit4@shostakovich4' \
		RABBITMQ_NODE_IP_ADDRESS='127.0.0.4' \
		RABBITMQ_DIST_PORT=25674 \
		RABBITMQ_CONFIG_FILE="$(CURDIR)/rabbit4.conf" \
		PLUGINS='rabbitmq_management rabbitmq_top' \
		RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS='-kernel inet_dist_use_interface {127,0,0,4} -kernel net_ticktime 5' run-broker
