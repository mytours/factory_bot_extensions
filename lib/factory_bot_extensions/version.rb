module FactoryBotExtensions
  begin
    old, $VERBOSE = $VERBOSE, nil
    VERSION = "2.1.0"
  ensure
    $VERBOSE = old
  end
end
