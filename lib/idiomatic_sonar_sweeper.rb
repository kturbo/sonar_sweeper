class IdiomaticSonarSweeper
  def self.increases_count(measure_collection)
    measure_collection.each_cons(2).count do |prev_measure, next_measure|
      next_measure > prev_measure
    end
  end

  attr_reader :depth_report

  def initialize(depth_report)
    raise(TypeError, "Report must be formatted as array!") unless depth_report.kind_of?(Array)

    @depth_report = depth_report
  end

  def aggregated_report
    depth_report.each_cons(3).map(&:sum)
  end

  def direct_increases_count
    self.class.increases_count(depth_report)
  end

  def aggregated_increases_count
    self.class.increases_count(aggregated_report)
  end
end
