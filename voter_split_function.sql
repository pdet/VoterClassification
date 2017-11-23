CREATE FUNCTION voter_split(precinct INT, id INT)
RETURNS TABLE(id INT, train BOOLEAN)
LANGUAGE PYTHON
{
    count = len(id)
    # generate the indices
    indices = numpy.arange(count)
    # shuffle the indices
    numpy.random.shuffle(indices)
    # assign 5% of the values to the train set
    train_indices = indices[:int(count * 0.05)]
    # create a boolean array that specifies for each value if it belongs to the train/test set
    train_set = numpy.zeros(count, dtype=numpy.bool)
    train_set[train_indices] = True
    return [id, train_set]
};