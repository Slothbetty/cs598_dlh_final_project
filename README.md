# Final Project for CS598 DL4H in Spring 2022

This repository is a reproduction of the "Automated ICD-9-CM medical coding of diabetic patient’s clinical reports" paper which was published in 2018[[1]](#1). We used the public MIMIC III dataset[[2]](#2) and reproduced the three parellel convolutional layers' CNN model, CNN baseline models and Bag of Tricks models to obtain the simliar result as the paper did.

●	Citation to the original paper(done)
●	Link to the original paper’s repo (if applicable)(no repo)
●	Dependencies
●	Data download instruction
●	Preprocessing code + command (if applicable)
●	Training code + command (if applicable)
●	Evaluation code + command (if applicable)
●	Pretrained model (if applicable)
●	Table of results (no need to include additional experiments, but main reproducibility result should be included)

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

## Training

To train the model(s) in the paper, run this command:

```train
python train.py --input-data <path_to_data> --alpha 10 --beta 20
```

>📋  Describe how to train the models, with example commands on how to train the models in your paper, including the full training procedure and appropriate hyperparameters.
## Evaluation

To evaluate my model on ImageNet, run:

```eval
python eval.py --model-file mymodel.pth --benchmark imagenet
```

>📋  Describe how to evaluate the trained models on benchmarks reported in the paper, give commands that produce the results (section below).
## Pre-trained Models

You can download pretrained models here:

- [My awesome model](https://drive.google.com/mymodel.pth) trained on ImageNet using parameters x,y,z. 

>📋  Give a link to where/how the pretrained models can be downloaded and how they were trained (if applicable).  Alternatively you can have an additional column in your results table with a link to the models.
## Results

Our model achieves the following performance on :

### [Image Classification on ImageNet](https://paperswithcode.com/sota/image-classification-on-imagenet)

| Model name         | Top 1 Accuracy  | Top 5 Accuracy |
| ------------------ |---------------- | -------------- |
| My awesome model   |     85%         |      95%       |

>📋  Include a table of results from your paper, and link back to the leaderboard for clarity and context. If your main result is a figure, include that figure and link to the command or notebook to reproduce it. 

## References
<a id="1">[1]</a> 
Pereira, V., Matos, S., & Oliveira, J. L. (2018, October). Automated ICD-9-CM medical coding of diabetic patient's clinical reports. In Proceedings of the First International Conference on Data Science, E-learning and Information Systems (pp. 1-6).<br />
<a id="2">[2]</a> 
Johnson, A., Pollard, T., & Mark, R. (2016). MIMIC-III Clinical Database (version 1.4). PhysioNet. https://doi.org/10.13026/C2XW26.<br />
<a id="3">[3]</a> 
Johnson, A. E. W., Pollard, T. J., Shen, L., Lehman, L. H., Feng, M., Ghassemi, M., Moody, B., Szolovits, P., Celi, L. A., & Mark, R. G. (2016). MIMIC-III, a freely accessible critical care database. Scientific Data, 3, 160035.<br />
<a id="4">[4]</a> 
Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220.<br />

## Contributing

>📋  Pick a licence and describe how to contribute to your code repository. 