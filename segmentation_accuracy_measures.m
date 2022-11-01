function [ITP, TP, ITN, TN, IFP, FP] = segmentation_accuracy_measures (Ib, Is, M, N)
cp = sum(sum(~Ib));
cn = M * N - cp;

% True Positive
ITP = Ib | Is;
TP = sum(sum(~ITP)) / cp;

% True Negative
ITN = (~xor(Ib, Is)) | Ib;
TN = sum(sum(~ITN)) / cn;

% False Positive
IFP = (~xor(Ib, Is)) | Is;
FP = sum(sum(~IFP)) / cn;