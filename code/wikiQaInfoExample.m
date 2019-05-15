st = scitran('cni');
st.verify
files = st.search('file',...
    'filename exact','16504_4_1_BOLD_EPI_Ax_AP.dicom.zip',...
    'filetype','dicom',...
    'project label exact','qa');
 info = st.fileInfoGet(files{1});
 disp(info)
 info.classification
 info.info
 
 
  files = st.search('file',...
    'project label exact','qa',...
    'session label exact','16542',...
    'acquisition label exact','4_1_BOLD_EPI_Ax_AP',...
    'filename contains','json',...
    'filetype','qa',...
    'summary',true);

qaInfo = st.fileInfoGet(files{1})
qaInfo.modality = 'MRI'
st.fileInfoSet(files{1},qaInfo);