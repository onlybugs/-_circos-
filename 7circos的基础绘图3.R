

#3.7 绘制圆形箭头,效果不错,要多看看
{
  #第一个例子
  fa = letters[1:4]
  col = rand_color(4)    #随机四个颜色
  tail = c("point", "normal", "point", "normal")  #建立四种箭头的末尾
  circos.initialize(fa,xlim = c(0,1))
  circos.track(ylim = c(0,1),
               panel.fun = function(x,y) #绘制箭头
               {
                 circos.arrow(x1 = 0,   #箭头起始位置
                              x2 = 1,   #箭头结束位置
                              y = CELL_META$ycenter,  #箭头中点位置
                              width = 0.3,    #箭头宽度
                              arrow.head.width = 0.6,   #箭头的头的宽度
                              arrow.head.length = ux(1, "cm"),   #箭头头的长度
                              col = col[CELL_META$sector.numeric.index], #使用颜色
                              tail = tail[CELL_META$sector.numeric.index] #使用类型
                 )
               },
               bg.border = NA,  #取消轨道边界
               track.height = 0.4)  #设置轨道高度为0.4
  
  #第二个例子,绘制细胞周期图
  cell_cycle = data.frame(phase = factor(c("G1", "S", "G2", "M"), levels = c("G1", "S", "G2", "M")),
                          hour = c(11, 8, 4, 1))
  color = c("#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3")
  circos.par(start.degree = 90)
  circos.initialize(cell_cycle$phase, xlim = cbind(rep(0, 4), cell_cycle$hour))
  circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
    circos.arrow(CELL_META$xlim[1], CELL_META$xlim[2], 
                 arrow.head.width = CELL_META$yrange*0.8, arrow.head.length = 0.5,
                 col = color[CELL_META$sector.numeric.index])
    circos.text(CELL_META$xcenter, CELL_META$ycenter, CELL_META$sector.index, 
                facing = "downward")
    circos.axis(h = 1, major.at = seq(0, round(CELL_META$xlim[2])), minor.ticks = 1,
                labels.cex = 0.6)
  }, bg.border = NA, track.height = 0.3)
  
  
}

#3.8 把图片加入到circos里,又叫光栅图
{
  load(system.file("extdata", "doodle.RData", package = "circlize"))
  circos.par("cell.padding" = c(0, 0, 0, 0))
  circos.initialize(letters[1:16], xlim = c(0, 1))
  
  circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
    img = img_list[[CELL_META$sector.numeric.index]]
    circos.raster(img, CELL_META$xcenter, CELL_META$ycenter, 
                  width = CELL_META$xrange, height = CELL_META$yrange, 
                  facing = "bending.inside")
  }, track.height = 0.25, bg.border = NA)
  
  circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
    img = img_list[[CELL_META$sector.numeric.index + 16]]
    circos.raster(img, CELL_META$xcenter, CELL_META$ycenter, 
                  width = CELL_META$xrange, height = CELL_META$yrange, 
                  facing = "bending.inside")
  }, track.height = 0.25, bg.border = NA)
  circos.clear()
}