rebar get-deps && rebar compile && erl -pa apps/rtcserver/ebin/ deps/*/ebin -s rtcserver_app
