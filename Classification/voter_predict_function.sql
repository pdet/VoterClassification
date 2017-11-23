CREATE OR REPLACE FUNCTION voter_predict(county INT, precinct INT, sex INT, race INT, ethnicity INT, age INT, id INT) 
RETURNS TABLE(id INT, prediction STRING) 
LANGUAGE PYTHON
{
    # don't use id for prediction
    del _columns['id']

    # load the classifier using a loopback query
    import cPickle
    # first load the pickled object from the database
    res = _conn.execute("SELECT cl_obj FROM Classifiers WHERE cl_name='Random Forest Classifier';")
    # Unpickle the string to recreate the classifier
    classifier = cPickle.loads(res['cl_obj'][0])

    # create a 2D array of the features
    data_array = numpy.array([])
    for x in _columns.values(): data_array = numpy.concatenate((data_array, x))
    data_array.shape = (len(id), len(_columns.keys()))

    # perform the actual classification
    result = dict()
    result['prediction'] = classifier.predict(data_array)
    result['id'] = id
    return result
};