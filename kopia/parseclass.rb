class Parser

    attr_accessor :pos
    attr_reader :rules, :string, :logger
  
    class ParseError < RuntimeError
    end
  
    def initialize(language_name, &block)
      @logger = Logger.new(nil)
      @lex_tokens = []
      @rules = {}
      @start = nil
      @language_name = language_name
      instance_eval(&block)
    end
    
    # Tokenize the string into small pieces
    def tokenize(string)
      @tokens = []
      @string = string.clone
      until string.empty?
        # Unless any of the valid tokens of our language are the prefix of
        # 'string', we fail with an exception
        raise ParseError, "unable to lex '#{string}" unless @lex_tokens.any? do |tok|
          match = tok.pattern.match(string)
          # The regular expression of a token has matched the beginning of 'string'
          if match
            @logger.debug("Token #{match[0]} consumed")
            # Also, evaluate this expression by using the block
            # associated with the token
            @tokens << tok.block.call(match.to_s) if tok.block
            # consume the match and proceed with the rest of the string
            string = match.post_match
            true
          else
            # this token pattern did not match, try the next
            false
          end # if
        end # raise
      end # until
    end
    
    def parse(string)
      # First, split the string according to the "token" instructions given.
      # Afterwards @tokens contains all tokens that are to be parsed. 
      tokenize(string)
  
      # These variables are used to match if the total number of tokens
      # are consumed by the parser
      @pos = 0
      @max_pos = 0
      @expected = []
      # Parse (and evaluate) the tokens received
      result = @start.parse
      # If there are unparsed extra tokens, signal error
      if @pos != @tokens.size
        raise ParseError, "Parse error. expected: '#{@expected.join(', ')}', found '#{@tokens[@max_pos]}'"
      end
      return result
    end
    
    def next_token
      @pos += 1
      return @tokens[@pos - 1]
    end
  
    # Return the next token in the queue
    def expect(tok)
      return tok if tok == :empty
      t = next_token
      if @pos - 1 > @max_pos
        @max_pos = @pos - 1
        @expected = []
      end
      return t if tok === t
      @expected << tok if @max_pos == @pos - 1 && !@expected.include?(tok)
      return nil
    end
    
    def to_s
      "Parser for #{@language_name}"
    end
  
    private
    
    LexToken = Struct.new(:pattern, :block)
    
    def token(pattern, &block)
      @lex_tokens << LexToken.new(Regexp.new('\\A' + pattern.source), block)
    end
    
    def start(name, &block)
      rule(name, &block)
      @start = @rules[name]
    end
    
    def rule(name,&block)
      @current_rule = Rule.new(name, self)
      @rules[name] = @current_rule
      instance_eval &block # In practise, calls match 1..N times
      @current_rule = nil
    end
    
    def match(*pattern, &block)
      # Basically calls memberfunction "match(*pattern, &block)
      @current_rule.send(:match, *pattern, &block)
    end
  
  end