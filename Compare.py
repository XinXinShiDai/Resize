import filecmp
UnResize = filecmp.cmp('C:/Users/Howard/Desktop/Resize/Sim_Files/Py_UnResize.txt','C:/Users/Howard/Desktop/Resize/Sim_Files/Sim_UnResize.txt')
print(UnResize)
Resize = filecmp.cmp('C:/Users/Howard/Desktop/Resize/Sim_Files/Py_Resize.txt','C:/Users/Howard/Desktop/Resize/Sim_Files/Sim_Resize.txt')
print(Resize)