CREATE OR REPLACE FUNCTION voter_preprocess(republican_percentage DOUBLE, county STRING, precinct STRING, sex STRING, race STRING, 
                                 ethnicity STRING, age INT) 
RETURNS TABLE(republican_percentage DOUBLE, county INT, precinct INT, sex INT, race INT, ethnicity INT, age INT) 
LANGUAGE PYTHON
{
    from sklearn import preprocessing
    result_columns = dict()

    # loop over all the columns
    for key in _columns.keys(): 
        if _column_types[key] == 'STRING': 
            # if the column is a string, we transform it 
            le = preprocessing.LabelEncoder()
            # fit the labelencoder on the data
            le.fit(_columns[key])
            # apply the labelencoder and store the result
            result_columns[key] = le.transform(_columns[key])
        else: 
            # if the column is not a string, we don't need to do anything
            result_columns[key] = _columns[key]
    return result_columns
};