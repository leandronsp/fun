#[cfg(test)]
mod tests {
    #[test]
    fn enums() {
        #[derive(PartialEq)]
        #[derive(Debug)]
        enum HTTPStatus {
            Ok,
            NotFound
        }

        let ok = HTTPStatus::Ok;
        let not_found = HTTPStatus::NotFound;

        assert_eq!(ok, HTTPStatus::Ok);
        assert_eq!(not_found, HTTPStatus::NotFound);
    }

    #[test]
    fn enums_variants_take_data() {
        #[derive(PartialEq)]
        #[derive(Debug)]
        enum HTTPStatus {
            Ok(i32),
            NotFound(i32)
        }

        let ok = HTTPStatus::Ok(200);
        let not_found = HTTPStatus::NotFound(404);

        assert_eq!(ok, HTTPStatus::Ok(200));
        assert_eq!(not_found, HTTPStatus::NotFound(404));
    }

    #[test]
    fn enums_can_have_methods() {
        #[derive(PartialEq)]
        #[derive(Debug)]
        enum HTTP {
            Status { code: i32 }
        }

        impl HTTP {
            fn code(&self) -> i32 {
                let HTTP::Status{ code } = self;
                *code
            }
        }

        let success = HTTP::Status{ code: 200 };
        let error = HTTP::Status{ code: 500 };

        assert_eq!(200, success.code());
        assert_eq!(500, error.code());
    }

    #[test]
    fn match_control_flow() {
        enum HTTP {
            Status(i32),
            Ok,
            NotFound
        }

        fn code(http: HTTP) -> i32 {
            match http {
                HTTP::Status(code) => code,
                HTTP::Ok => 200,
                HTTP::NotFound => 404
            }
        }

        assert_eq!(200, code(HTTP::Status(200)));
        assert_eq!(200, code(HTTP::Ok));
        assert_eq!(404, code(HTTP::NotFound));
    }

    #[test]
    fn if_let_control_flow() {
        struct Verb<'t>(&'t str);
        struct Path<'t>(&'t str);
        struct Protocol<'t>(&'t str);
        struct Body<'t>(&'t str);
        struct Status(i32);

        enum HTTP<'t> {
            Request(Verb<'t>, Path<'t>, Protocol<'t>, Body<'t>),
            Response(Protocol<'t>, Status, Body<'t>)
        }

        fn process_request(request: HTTP) -> HTTP {
            let (verb, path) = if let HTTP::Request(Verb(verb), Path(path), ..) = request { (verb, path) }
                               else { todo!() };

            match (verb, path) {
                ("GET", "/") => { return HTTP::Response(Protocol("HTTP/1.1"), Status(200), Body("PONG")) },
                _            => { return HTTP::Response(Protocol("HTTP/1.1"), Status(404), Body("PONG")) }
            }
        }

        let request = HTTP::Request(Verb("GET"), Path("/"), Protocol("HTTP/1.1"), Body("PING"));
        let response = process_request(request);

        if let HTTP::Response(_, Status(status), ..) = response { assert_eq!(status, 200) }

        let request = HTTP::Request(Verb("POST"), Path("/asdf"), Protocol("HTTP/1.1"), Body("PING"));
        let response = process_request(request);

        if let HTTP::Response(_, Status(status), ..) = response { assert_eq!(status, 404) }
    }

    #[test]
    fn if_let_control_flow_v2() {
        struct Verb(String);
        struct Path(String);
        struct Protocol(String);
        struct Body(String);
        struct Status(i32);

        enum HTTP {
            Request(Verb, Path, Protocol, Body),
            Response(Protocol, Status, Body)
        }

        fn process_request(request: HTTP) -> HTTP {
            let (verb, path) = if let HTTP::Request(Verb(verb), Path(path), ..) = request { (verb, path) }
            else { todo!() };

            match (verb, path) {
                ("GET", "/") => { return HTTP::Response(Protocol("HTTP/1.1"), Status(200), Body("PONG")) },
                _            => { return HTTP::Response(Protocol("HTTP/1.1"), Status(404), Body("PONG")) }
            }
        }

        let request = HTTP::Request(Verb("GET"), Path("/"), Protocol("HTTP/1.1"), Body("PING"));
        let response = process_request(request);

        if let HTTP::Response(_, Status(status), ..) = response { assert_eq!(status, 200) }

        let request = HTTP::Request(Verb("POST"), Path("/asdf"), Protocol("HTTP/1.1"), Body("PING"));
        let response = process_request(request);

        if let HTTP::Response(_, Status(status), ..) = response { assert_eq!(status, 404) }
    }
}
