### 8. Applying the model to a case study site - uploading the mosaic into R and assigning different substrate types
# different settlement probabilities.

### Load in the mosaic of your reef area
library('png')

ans=readPNG("Real_mosaic.png")

dim(ans)

par(mfrow=c(2,2))
image(t(ans[999:1,,1]))
image(ans[,,2])
image(ans[,,3])
image(ans[,,4])

rc=t(ans[999:1,,1])
image(rc)
gc=t(ans[999:1,,2])
bc=t(ans[999:1,,3])
ac=rc+gc+bc
#image(ac)
plot(c(rc))
plot(c(gc))
plot(c(bc))
hist(c(rc))
hist(c(gc))
hist(c(bc))

image(gc<0.2)  		## dark red - dead stag
image(gc<0.58 & gc>0.2) ## orange - live coral
image(gc>0.58 & gc<0.7) ## blue - deadcoral
image(gc>0.7 & gc<0.82) ## yellow - sand
image(gc>0.82) 		## green - rubble

dim(gc)
submat = matrix(0,nrow=1365,ncol=999)
submat[gc<0.2] = 3
submat[gc<0.58 & gc>0.2] = 1
submat[gc>0.58 & gc<0.7] = 4
submat[gc>0.82] = 2

unique(c(submat))
windows(width=5,height=5)
image(submat,asp=999/1365)
save(submat,file="Real_mosaic")

