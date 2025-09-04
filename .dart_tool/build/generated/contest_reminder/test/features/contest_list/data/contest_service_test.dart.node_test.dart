          
          import "package:test/bootstrap/node.dart";

          import "contest_service_test.dart" as test;

          void main() {
            internalBootstrapNodeTest(() => test.main);
          }
        