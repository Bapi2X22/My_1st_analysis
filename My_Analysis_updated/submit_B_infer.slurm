#!/bin/bash -l
#SBATCH --time=72:00:00
#SBATCH --ntasks=4
#SBATCH --mem=100g
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --mail-user=bapibasakfulia@gmail.com
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH --job-name="timAhcal_valid"
#SBATCH --partition=gpu

#folder="/home/bbapi/test"
folder="/home/bbapi/AtoGG_merged/PickleMaker/1M_test_EE_Bapi"
#folder2="/home/bbapi/AtoGG_merged/PickleMaker/1M_test_EE_Bapi/inference_1"
#v2->trueE, no semi
#v1->semi_dscb, loss fun= dscb

#export PYTHONUNBUFFERED=1
#module load ohpc
#module load iiser/apps/cuda/11.4
#module load cmake/3.14.3
#module swap gnu8 cdac/compiler/gcc/10.2.0
#module load python/3.9.8
module load iiser/apps/cuda/11.4 

module load cdac/spack/0.17
source /home/apps/spack/share/spack/setup-env.sh
spack load python@3.8.2
source /home/apps/iiser/pytorch-venv/bin/activate

#export CUDA_VISIBLE_DEVICES=0,1,2,3 

#module load cdac/compiler/gcc/10.2.0
#module spider graphviz
#source activate torch1.8
#cd /home/bbapi/AtoGG_merged/PickleMaker/ 
#./MypreparePickles_EE 1 1 1 &>> $folder/training.log

#/home/bbapi/AtoGG_merged/DRN_AtoGG/train $folder $folder --nosemi --idx_name all --target trueE --in_layers 3 --mp_layers 4 --out_layers 2  --agg_layers 3 --valid_batch_size 300 --train_batch_size 300  --lr_sched Const --max_lr 0.0001 --pool max --ES no --hidden_dim 64 --n_epochs 200 &>> $folder/training.log
/home/bbapi/AtoGG_merged/DRN_AtoGG/train $folder $folder --nosemi --idx_name all --target trueE --in_layers 3 --mp_layers 4 --out_layers 2  --agg_layers 3 --valid_batch_size 20 --train_batch_size 20  --lr_sched Const --max_lr 0.0001 --pool max --ES no --hidden_dim 64 --n_epochs 200 --predict_only &>> $folder/training.log

#path to DRN/train outfolder folder_with_pickles  --nosemi --idx_name all --target trueE --in_layers 3 --mp_layers 4 --out_layers 2  --agg_layers 3 --valid_batch_size 300 --train_batch_size 300  --lr_sched Const --max_lr 0.0001 --pool max --ES yes --hidden_dim 64 --n_epochs 200 &>> outfolder/training.log

#To predict add a "--predict_only" argument

