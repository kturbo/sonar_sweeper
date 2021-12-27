def increases_count(measure_collection)
  measure_collection.each_cons(2).count do |prev_measure, next_measure|
    next_measure > prev_measure
  end
end

simple_increases = increases_count(test_data)

aggregated_measures = test_data.each_cons(3).map(&:sum)

aggregated_increases = increases_count(aggregated_measures)
