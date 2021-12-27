require 'benchmark'
require_relative './lib/generic_sonar_sweeper'
require_relative './lib/idiomatic_sonar_sweeper'

data_file = File.read("test_data.txt")
test_data = Kernel.eval(data_file)

Benchmark.bm( 30 ) do |bm|
  bm.report("Generic") do
    500.times do
      sweeper = GenericSonarSweeper.new(test_data)
      sweeper.direct_increases_count
      sweeper.aggregated_increases_count
    end
  end

  bm.report("Idiomatic") do
    500.times do
      sweeper = IdiomaticSonarSweeper.new(test_data)
      sweeper.direct_increases_count
      sweeper.aggregated_increases_count
    end
  end
end
