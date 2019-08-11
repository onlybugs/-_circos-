

#3.9 连接
{
  #四种基本的链接参数调用
  circos.link(sector.index1, 0, sector.index2, 0)
  circos.link(sector.index1, c(0, 1), sector.index2, 0)
  circos.link(sector.index1, c(0, 1), sector.index2, c(1, 2))
  circos.link(sector.index1, c(0, 1), sector.index2, 0, col, lwd, lty, border)
}

#3.11 circos是可以使用R基本绘图的低级函数的,比如legend text title等等
{
  factors = letters[1:4]
  circos.initialize(factors = factors, xlim = c(0, 1))
  circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
    circos.points(1:20/20, 1:20/20)
  })
  text(0, 0, "This is\nthe center", cex = 1.5)
  legend("bottomleft", pch = 1, legend = "This is the legend")
  title("This is the title")
}