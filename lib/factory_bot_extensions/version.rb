module FactoryBotExtensions
  begin
    old, $VERBOSE = $VERBOSE, nil
    VERSION = "6.1.0"
  ensure
    $VERBOSE = old
  end
end
