import nibabel as nib
import numpy as np
import pandas as pd

img        = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Gene_expression_Analysis/All_Brains/aparc+aseg_MNI152_8mm.nii.gz')
data       = img.get_data()

meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State1_PCORR_8mm.nii.gz')
meg_data_1 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State2_PCORR_8mm.nii.gz')
meg_data_2 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State3_PCORR_8mm.nii.gz')
meg_data_3 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State4_PCORR_8mm.nii.gz')
meg_data_4 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State5_PCORR_8mm.nii.gz')
meg_data_5 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State6_PCORR_8mm.nii.gz')
meg_data_6 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State7_PCORR_8mm.nii.gz')
meg_data_7 = meg_img.get_data()
meg_img    = nib.load('/Users/Dan/Desktop/MPhil/Project_CBU/PCORR_GENE_Parcels/Seperated_States/8mm/State8_PCORR_8mm.nii.gz')
meg_data_8 = meg_img.get_data()

labels     = [1001, 1002, 1003, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 2001, 2002, 2003, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035]

np.save('/Users/Dan/Desktop/DK_Template_MN1152_8mm.npy',data)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_1)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_2)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_3)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_4)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_5)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_6)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_7)
np.save('/Users/Dan/Desktop/State_1.npy',meg_data_8)