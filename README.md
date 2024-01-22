# Reproduction steps

## Start cluster

```
make up
```

## Ensure running

* PerfTest will be publishing & consuming
* Management UI at `server:15672` will be available

## Disconnect

* List running containers, choose one to disconnect
    ```
    docker compose ps
    ```
* Disconnect
    ```
    docker network disconnect rabbitnet rabbitmq-server-8113-rmq0-1
    ```
* Wait for node to stop itself
    ```
    rabbitmq-server-8113-rmq0-1 | 2023-05-05 22:55:44 [info] <0.2189.0> Successfully stopped RabbitMQ and its dependencies
    ```

## Reconnect

```
docker network connect --alias rmq0.local rabbitnet rabbitmq-server-8113-rmq0-1
```

## Error

The following error will be logged pretty quickly, and the node will not start.

Note the `Feature flags: checking nodes...` message that happens right at the end of the node shutdown due to `pause_minority`.

```
2023-05-05 22:57:05 [notice] <0.44.0> Application mnesia exited with reason: stopped
2023-05-05 22:57:05 [notice] <0.2315.0> Feature flags: checking nodes `rabbit@rmq0.local` and `rabbit@rmq2.local` compatibility...
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags: error while running:
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags:   rabbit_ff_registry:inventory[]
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags: on node `rabbit@rmq1.local`:
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags:   exception error: {erpc,noconnection}
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags:     in function  erpc:call/5 (erpc.erl, line 710)
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags:     in call from rabbit_ff_controller:rpc_call/5 (rabbit_ff_controller.erl, line 1123)
2023-05-05 22:57:19 [error] <0.2363.0> Feature flags:     in call from rabbit_ff_controller:'-rpc_calls/5-fun-1-'/7 (rabbit_ff_controller.erl, line 1172)
2023-05-05 22:57:19 [error] <0.2363.0>
2023-05-05 22:57:19 [warning] <0.2315.0> Feature flags: nodes `rabbit@rmq0.local` and `rabbit@rmq2.local` are incompatible
2023-05-05 22:57:19 [error] <0.2315.0>
2023-05-05 22:57:19 [error] <0.2315.0> BOOT FAILED
2023-05-05 22:57:19 [error] <0.2315.0> ===========
2023-05-05 22:57:19 [error] <0.2315.0> Error during startup: {error,incompatible_feature_flags}
2023-05-05 22:57:19 [error] <0.2315.0>
2023-05-05 22:57:20 [error] <0.2314.0>   crasher:
2023-05-05 22:57:20 [error] <0.2314.0>     initial call: application_master:init/4
2023-05-05 22:57:20 [error] <0.2314.0>     pid: <0.2314.0>
2023-05-05 22:57:20 [error] <0.2314.0>     registered_name: []
2023-05-05 22:57:20 [error] <0.2314.0>     exception exit: {incompatible_feature_flags,{rabbit,start,[normal,[]]}}
2023-05-05 22:57:20 [error] <0.2314.0>       in function  application_master:init/4 (application_master.erl, line 142)
2023-05-05 22:57:20 [error] <0.2314.0>     ancestors: [<0.2313.0>]
2023-05-05 22:57:20 [error] <0.2314.0>     message_queue_len: 1
2023-05-05 22:57:20 [error] <0.2314.0>     messages: [{'EXIT',<0.2315.0>,normal}]
2023-05-05 22:57:20 [error] <0.2314.0>     links: [<0.2313.0>,<0.44.0>]
2023-05-05 22:57:20 [error] <0.2314.0>     dictionary: []
2023-05-05 22:57:20 [error] <0.2314.0>     trap_exit: true
2023-05-05 22:57:20 [error] <0.2314.0>     status: running
2023-05-05 22:57:20 [error] <0.2314.0>     heap_size: 233
2023-05-05 22:57:20 [error] <0.2314.0>     stack_size: 28
2023-05-05 22:57:20 [error] <0.2314.0>     reductions: 160
2023-05-05 22:57:20 [error] <0.2314.0>   neighbours:
2023-05-05 22:57:20 [error] <0.2314.0>
2023-05-05 22:57:20 [notice] <0.44.0> Application rabbit exited with reason: {incompatible_feature_flags,{rabbit,start,[normal,[]]}}
2023-05-05 22:57:20 [notice] <0.44.0> Application osiris exited with reason: stopped
2023-05-05 22:57:20 [notice] <0.44.0> Application sysmon_handler exited with reason: stopped
2023-05-05 22:57:20 [notice] <0.44.0> Application ra exited with reason: stopped
2023-05-05 22:57:20 [notice] <0.44.0> Application os_mon exited with reason: stopped
2023-05-05 22:57:20 [error] <0.2189.0> rabbit_outside_app_process:
2023-05-05 22:57:20 [error] <0.2189.0> {error,{rabbit,{incompatible_feature_flags,{rabbit,start,[normal,[]]}}}}
2023-05-05 22:57:20 [error] <0.2189.0> [{rabbit,start_it,1,[{file,"rabbit.erl"},{line,418}]},
2023-05-05 22:57:20 [error] <0.2189.0>  {rabbit_node_monitor,do_run_outside_app_fun,1,
2023-05-05 22:57:20 [error] <0.2189.0>                       [{file,"rabbit_node_monitor.erl"},{line,795}]}]
```

# `epmd` error

```
2023-05-19 15:22:11.868396+00:00 [error] <0.2657.0> BOOT FAILED
2023-05-19 15:22:11.868396+00:00 [error] <0.2657.0> ===========
2023-05-19 15:22:11.868396+00:00 [error] <0.2657.0> Error during startup: {error,no_epmd_port}
2023-05-19 15:22:11.868396+00:00 [error] <0.2657.0> 
2023-05-19T15:22:11.865653+00:00 warning: FORMATTER CRASH: {"epmd does not know us, re-registering ~s at port ~b",["rabbit",undefined]}
```
