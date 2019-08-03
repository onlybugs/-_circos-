#2.4 par函数(确定基本绘图参数)
  {
    circos.par(gap.degree = 5,  #指定两个CELL的缝隙的距离,默认为1
               track.height = 0.1  #指定CELL的高度,默认为0.5，即可以画5层
               )
  }
  
  #2.5 创建绘图区circos.track()
  {
    #如果要改变所有背景色不同,需要传入等同于扇区数量的向量c('red','red','red)
    circos.track(factors = df$factor,x = df$x,y = df$y,
                 bg.col= 'red',bg.border = 1,
                 panel.fun = function(x,y){}
                )
    
  }
  
  #2.6 更新绘图区域,其实就是擦掉重新画一个
  {
    circos.update(sector.index, track.index)
    circos.points(x, y, sector.index, track.index)
  }