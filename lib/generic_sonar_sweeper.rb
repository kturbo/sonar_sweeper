class GenericSonarSweeper
  def self.increases_count(measure_collection)
    count = 0
    prev_measure = measure_collection[0]
    i = 1
    while i < measure_collection.size do
      count += 1 if measure_collection[i] > prev_measure
      prev_measure = measure_collection[i]
      i += 1
    end
    count
  end

  attr_reader :depth_report

  def initialize(depth_report)
    raise(TypeError, "Report must be formatted as array!") unless depth_report.kind_of?(Array)

    @depth_report = depth_report
  end

  def aggregated_report
    aggregated_measures = []
    return aggregated_measures if depth_report.size < 3
    first_measure = depth_report[0]
    middle_measure = depth_report[1]
    i = 1
    while i < depth_report.size - 1 do
      i += 1
      aggregated_measures << (first_measure + middle_measure + depth_report[i])
      first_measure, middle_measure = middle_measure, depth_report[i]
    end
    aggregated_measures
  end

  def direct_increases_count
    self.class.increases_count(depth_report)
  end

  def aggregated_increases_count
    self.class.increases_count(aggregated_report)
  end
end
