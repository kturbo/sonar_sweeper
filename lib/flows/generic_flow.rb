def increases_count(measure_collection)
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

simple_increases = increases_count(test_data)

aggregated_measures = []
if test_data.size >= 3
  first_measure = test_data[0]
  middle_measure = test_data[1]
  i = 1
  while i < test_data.size - 1 do
    i += 1
    aggregated_measures << (first_measure + middle_measure + test_data[i])
    first_measure, middle_measure = middle_measure, test_data[i]
  end
end

aggregated_increases = increases_count(aggregated_measures)
