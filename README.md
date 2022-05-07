# Final Project for CS598 DL4H in Spring 2022

This repository is a reproduction of the "Automated ICD-9-CM medical coding of diabetic patient’s clinical reports" paper which was published in 2018[[1]](#1). We used the public MIMIC III dataset[[2]](#2) and reproduced the three parellel convolutional layers' CNN model, CNN baseline models and Bag of Tricks models to obtain the simliar result as the paper did.

## Dependencies

Following are the dependencies we applied in our code, which could be easily installed by run all in the google colab:
```Setup
!pip install -U strsimpy
!pip install simplejson
```

## Data download instruction

Following are the data download instruction for our project:
1. Apply the access to MIMIC-III Clinical Database V1.4 through this link. https://eicu-crd.mit.edu/gettingstarted/access/
2. Register account for MIMIC-III Clinical Database V1.4 and upload the corresponding certificate document.
3. Access the Clinical Database through Google Bigquery and execute the query in dataset_generation.sql there. Export the query running result as a csv file and save it. This csv file is the raw data that we are going to use in our project.

## Preprocessing code

Following are the steps to preprocess the raw data:
1. Save the raw data into your local drive or google drive. Use the preprocessing_data.ipynb first half part of code(till corpus_line.txt block) to generate corpus_line.txt file to get all possible token strings.
2. Run the generate_rare_common_words_dictionary.ipynb with the raw data and save a rare_common_words_mapping.json file. This json will be used as words' replacement
3. Run the remaining code in the preprocessing_data.ipynb. It will save the data into a csv file, this is the data file that we will use in our model training and testing part.

## Training code and Evaluation code

To train and evaluate our models, just simply run all in the jupyter notebooks above:
model_without_cat.ipynb<br/>
models_cat.ipynb<br/>

## Table of results 

Following are the performance results of our models:

Multi-label Classification Result:

![multi-label classification](/images/Multi-label classification subtask result.png)

Multi-label vs Binary Classification Result:

![multi-label vs binary classification](/images/Multi-label vs Binary classification result.png)

## References
<a id="1">[1]</a> 
Pereira, V., Matos, S., & Oliveira, J. L. (2018, October). Automated ICD-9-CM medical coding of diabetic patient's clinical reports. In Proceedings of the First International Conference on Data Science, E-learning and Information Systems (pp. 1-6).<br />
<a id="2">[2]</a> 
Johnson, A., Pollard, T., & Mark, R. (2016). MIMIC-III Clinical Database (version 1.4). PhysioNet. https://doi.org/10.13026/C2XW26.<br />
<a id="3">[3]</a> 
Johnson, A. E. W., Pollard, T. J., Shen, L., Lehman, L. H., Feng, M., Ghassemi, M., Moody, B., Szolovits, P., Celi, L. A., & Mark, R. G. (2016). MIMIC-III, a freely accessible critical care database. Scientific Data, 3, 160035.<br />
<a id="4">[4]</a> 
Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220.<br />
