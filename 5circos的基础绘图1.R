library(circlize)

#3.1 点图
{
  circos.points(
    x,y,   
    pch = 1,
    cex = 2,
    col = 3
  )
  circos.trackPoints()  #参数同上
}

#3.2 线图
{
  #直接画线,不画出面积
  circos.lines(x,y,  #坐标
               col,  #指定颜色
               lwd, lty,  #指定线宽以及线的类型
               type     #指定图的类型,o 折线散点,s 阶梯线,h 垂线,l普通线
  )
  #填充线和坐标轴围成的面积
  circos.lines(x,y,  #坐标
               area = T,  #填充颜色
               col,  #指定填充颜色
               border, #指定边框颜色
               baseline,  #基线,就是截断的位置‘top'向圆外填充,还有bottom是默认
               type     #指定图的类型,o 折线散点,s 阶梯线,h 垂线,l普通线
  )
  
  #截断的用法,type为h时,大于5和小于5划分为绿色还有红色
  circos.lines(x,y,  #坐标
               col = c('red','green'),
               baseline = 5,
               type = h
  )
  
}

#3.3 细分轨道,将一个轨道进行细分
{
  circos.segments(x0, y0, x1, y1)
  circos.segments(x0, y0, x1, y1, straight)
}