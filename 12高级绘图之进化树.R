library(circlize)

#5.3 进化树的绘制  
{
  data(bird.orders)
  hc = as.hclust(bird.orders)  #聚类建树文件
  
  labels = hc$labels  # 鸟类名字
  ct = cutree(hc, 6)  # 将分割为6和树枝
  n = length(labels)  # 得到鸟类的总名字数量
  dend = as.dendrogram(hc) #转化为dend对象为了等下由.dendrogram使用
  
  circos.par(cell.padding = c(0, 0, 0, 0))
  circos.initialize(factors = "a", xlim = c(0, n)) # only one sector
  #绘制树的外圈
  circos.track(ylim = c(0, 1), bg.border = NA, track.height = 0.3, 
               panel.fun = function(x, y) {
                 for(i in seq_len(n)) {
                   circos.text(i-0.5, 0, labels[i], adj = c(0, 0.5), 
                               facing = "clockwise", niceFacing = TRUE,
                               col = ct[labels[i]], cex = 0.5)
                 }
               })
  #创建树
  suppressPackageStartupMessages(library(dendextend))
  dend = color_branches(dend, k = 6, col = 1:6)
  dend_height = attr(dend, "height")
  circos.track(ylim = c(0, dend_height), bg.border = NA, 
               track.height = 0.4, panel.fun = function(x, y) {
                 circos.dendrogram(dend)
               })
  
  circos.clear()
  #将树枝向内绘制
  #circos.dendrogram(dend, facing = "inside")
}