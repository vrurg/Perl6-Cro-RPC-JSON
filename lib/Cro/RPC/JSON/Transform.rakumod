use v6.d;
unit role Cro::RPC::JSON::Transform:api<2>;

use Cro::RPC::JSON::Exception;
use Cro::RPC::JSON::Response;
use Cro::Transform;

also does Cro::Transform;

# Helper to emit a valid JSON-RPC response from an X::Cro::RPC::JSON.
method !jsonify-exception(Exception:D $ex) {
    if $ex ~~ X::Cro::RPC::JSON {
        emit Cro::RPC::JSON::Response.new:
            json-body => %(
                jsonrpc => "2.0",
                error => %(
                    code => $ex.jrpc-code,
                    message => $ex.msg,
                )
            );
    }
}

# Copyright (c) 2018-2021, Vadim Belman <vrurg@cpan.org>
