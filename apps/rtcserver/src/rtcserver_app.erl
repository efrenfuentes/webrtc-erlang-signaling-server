-module(rtcserver_app).
-behaviour(application).
-export([start/2, stop/1, start/0]).
start() ->
    ok = application:start(compiler),
    ok = application:start(crypto),
    ok = application:start(asn1),
    ok = application:start(public_key),
    ok = application:start(ssl),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(gproc),
    ok = application:start(rtcserver).
    
start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_',[
                {"/", handler_websocket,[]}
        ]}
    ]),

    {ok, _} = cowboy:start_clear(websocket, [{port,30000}], #{env => #{dispatch => Dispatch}}),
        
    rtcserver_sup:start_link().

stop(_State) -> ok.
    
            
