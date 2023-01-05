# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::UnnecessaryMap, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `#map when not using the return`' do
    expect_offense(<<~RUBY)
      def map_not_needed
        [1,2,3].map{|n| puts n}
                ^^^ Use `#each` instead of `#map` when return value is unused.
        "done"
      end
    RUBY
  end

  it 'does not register an offense when using `#map` and using the return' do
    expect_no_offenses(<<~RUBY)
    def map_needed
      [1,2,3].map{|n| n + 1}
    end
    RUBY
  end
end
