library(circlize)

#3.4 添加文本,没啥可说的，下一个
{
  circos.text(x, y, labels)
  circos.text(x, y, labels, sector.index, track.index)
  circos.text(x, y, labels, facing, niceFacing, adj, cex, col, font)
}

#3.5 绘制矩形和多边形  矩形可能更有用,多边形就算了
{
  #绘制矩形,参数一读就懂
  circos.rect(xleft, ybottom, xright, ytop)
  circos.rect(xleft, ybottom, xright, ytop, sector.index, track.index)
  circos.rect(xleft, ybottom, xright, ytop, col, border, lty, lwd)
  #绘制多边形,注意,第一个数据点必须和最后一个数据点重合
  circos.polygon(x, y)
  circos.polygon(x, y, col, border, lty, lwd)
  
}

#3.6 绘制轴axis
{
  #h可以是bottom和top和数值,h表示axis出现的位置
  #默认就挺好,指定指定h就不错,需要可以仔细查看帮助文档
  circos.axis(h)
  circos.axis(h, sector.index, track.index)
  circos.axis(h, major.at, labels, major.tick, direction)
  circos.axis(h, major.at, labels, major.tick, labels.font, labels.cex,
              labels.facing, labels.niceFacing)
  circos.axis(h, major.at, labels, major.tick, minor.ticks,
              major.tick.length, lwd)
  
  #circos.yaxis也可以一样方法的使用,但是要指定一下gap.degree
}