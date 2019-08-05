 #2.7 panel.fun
  {
    #get.cell.meta和CELL_META本质是一个东西
    #后者是前者的一个简写
    #get.cell.meta('sector.index')和CELL_META$sector.index
    #是一个结果
    #二者都是提取当前单元格的各种信息
    #常用的信息
    #$sector.index,track.index,xlim,ylim,xcenter,sector.numeric.index
    #ycenter
    #然后就可以这样
    circos.text(CELL_META$xcenter,CELL_META$ycenter,CELL_META$sector.index)
    
    
  }
  
  #2.8 一些使用绝对数值的例子
  {
    fa = letters[1:10]
    circos.par(cell.padding = c(0, 0, 0, 0), track.margin = c(0, 0))
    circos.initialize(fa, xlim = cbind(rep(0, 10), runif(10, 0.5, 1.5)))
    circos.track(ylim = c(0, 1), track.height = uh(5, "mm"),
                 panel.fun = function(x, y) {
                   circos.lines(c(0, 0 + ux(5, "mm")), c(0.5, 0.5), col = "blue")
                   circos.text(CELL_META$xcenter,CELL_META$ycenter,CELL_META$sector.index)
                 })
    circos.track(ylim = c(0, 1), track.height = uh(1, "cm"),
                 track.margin = c(0, uh(2, "mm")),
                 panel.fun = function(x, y) {
                   xcenter = get.cell.meta.data("xcenter")
                   circos.lines(c(xcenter, xcenter), c(0, uy(1, "cm")), col = "red")
                 })
    circos.track(ylim = c(0, 1), track.height = uh(1, "inches"),
                 track.margin = c(0, uh(5, "mm")),
                 panel.fun = function(x, y) {
                   line_length_on_x = ux(1*sqrt(2)/2, "cm")
                   line_length_on_y = uy(1*sqrt(2)/2, "cm")
                   circos.lines(c(0, line_length_on_x), c(0, line_length_on_y), col = "orange")
                 })
    
  }
  #circos.info()用来输出当前图形的信息,也可以具体定位到一个CELL
  circos.info()
  circos.info(sector.index = 'a',track.index = 1)