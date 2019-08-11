

#3.10 突出显示
{
  #3.10.1 draw.sector函数概述
  #前两个参数为开始角度和结束角度
  #要是指定了rou1和rou2就表示绘制环
  #col border 无所谓,center默认为圆心c(0,0)，可以自己指定
  par(mar = c(1, 1, 1, 1))
  plot(c(-1, 1), c(-1, 1), type = "n", axes = FALSE, ann = FALSE, asp = 1)
  draw.sector(20, 0)
  draw.sector(30, 60, rou1 = 0.8, rou2 = 0.5, clock.wise = FALSE, col = "#FF000080")
  draw.sector(350, 1000, col = "#00FF0080", border = NA)
  draw.sector(0, 180, rou1 = 0.25, center = c(-0.5, 0.5), border = 2, lwd = 2, lty = 2)
  draw.sector(0, 360, rou1 = 0.7, rou2 = 0.6, col = "#0000FF80")
  
  #3.10.2  高亮轨道和扇区draw.sector
  {
    #初始化
    factors = letters[1:8]
    circos.initialize(factors, xlim = c(0, 1))
    for(i in 1:3) {
      circos.track(ylim = c(0, 1))    #初始化三个轨道
    }
    circos.info(plot = TRUE)   #在图中绘制信息
    #突出扇区a
    draw.sector(get.cell.meta.data("cell.start.degree", sector.index = "a"),
                get.cell.meta.data("cell.end.degree", sector.index = "a"),
                rou1 = get.cell.meta.data("cell.top.radius", track.index = 1), 
                col = "#FF000040")
    #突出轨道1
    draw.sector(0, 360, 
                rou1 = get.cell.meta.data("cell.top.radius", track.index = 1),
                rou2 = get.cell.meta.data("cell.bottom.radius", track.index = 1),
                col = "#00FF0040")
    #突出轨道2和轨道3的e和f扇区
    draw.sector(get.cell.meta.data("cell.start.degree", sector.index = "e"),
                get.cell.meta.data("cell.end.degree", sector.index = "f"),
                rou1 = get.cell.meta.data("cell.top.radius", track.index = 2),
                rou2 = get.cell.meta.data("cell.bottom.radius", track.index = 3),
                col = "#0000FF40")
  }
  
  #3.10.3  更简单的突出highlight.sector 建议选择使用这个
  {
    factors = letters[1:8]
    circos.initialize(factors, xlim = c(0, 1))
    for(i in 1:4) {
      circos.track(ylim = c(0, 1))
    }
    circos.info(plot = TRUE)
    #添加分组
    highlight.sector(c("a", "h"), track.index = 1, text = "a and h belong to a same group",
                     facing = "bending.inside", text.vjust = "6mm", cex = 0.8)
    #给c区添加颜色
    highlight.sector("c", col = "#00FF0040")
    #给d区添加一个红色的边框
    highlight.sector("d", col = NA, border = "red", lwd = 2)
    #给2和3轨道的e区添加颜色
    highlight.sector("e", col = "#0000FF40", track.index = c(2, 3))
    #给2和3轨道的f和g区添加一个溢出的边框
    highlight.sector(c("f", "g"), col = NA, border = "green", 
                     lwd = 2, track.index = c(2, 3), padding = c(0.1, 0.1, 0.1, 0.1))
    #给4轨道添加颜色
    highlight.sector(factors, col = "#FFFF0040", track.index = 4)
    
  }
}