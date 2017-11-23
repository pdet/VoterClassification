CREATE FUNCTION voter_train
                    (republican_percentage DOUBLE, county INT, precinct INT, sex INT, race INT, ethnicity INT, age INT) 
RETURNS TABLE(cl_name STRING, cl_obj STRING)
LANGUAGE PYTHON
{
    import cPickle
    count = len(county)
    from sklearn.ensemble import RandomForestClassifier
    clf = RandomForestClassifier(n_estimators=10)

    # randomly generate the classes
    random = numpy.random.rand(count)
    classes = numpy.zeros(count, dtype='S10')
    classes[random < republican_percentage] = 'Republican'
    classes[random > republican_percentage] = 'Democrat'
    
    # exclude republican_percentage from the feature set
    del _columns['republican_percentage']

    # construct a 2D array from the features
    data_array = numpy.array([])
    for x in _columns.values(): data_array = numpy.concatenate((data_array, x))
    data_array.shape = (count, len(_columns.keys()))

    # train the classifier
    clf.fit(data_array, classes)

    # export the classifier to the database
    return dict(cl_name="Random Forest Classifier", cl_obj=cPickle.dumps(clf))
};