  #2.1 circos图的设计过程
  #init -> 添加track -> 添加基本图形 -> 添加轨道 .... -> clear
  
  #2.2 制作图形的三种方法
  {
    #创建了轨道后有三个方式绘制轨道上的内容
    #1 推荐方法panel.fun,在panel.fun里使用circos.的CELL绘图函数
    {
      circos.initialize(factors, xlim)
      circos.track(factors, all_x, all_y, ylim,
                   panel.fun = function(x, y) {
                     circos.points(x, y)
                     circos.lines(x, y)
                   })
    }
    #2 绘制一圈一样的，再初始化之后，使用circos.track***绘制所有的
    {
      circos.initialize(factors, xlim)
      circos.track(factors, ylim)
      circos.trackPoints(factors, x, y)
      circos.trackLines(factors, x, y)
      
    }
    #3 最不推荐的方法,绘制布局之后使用循环再CELL中绘图
    {
      circos.initialize(factors, xlim)
      circos.track(factors, ylim)
      for(sector.index in all.sector.index) {
        circos.points(x1, y1, sector.index)
        circos.lines(x2, y2, sector.index)
      }
      
    }
  }
  
  #2.3 init函数(初始化circos)
  {
    #限定扇区的大小可以用x = x系统将自己确定,
    #也可以传入等同于扇区大小行数的二列矩阵,分别对个个行进行限定如2.8中的例子
    #扇区的顺序由传入的factors的levels决定,如果传入字符串则为unique(factor)
    #此时扇区顺序为a b c d e f g
    fa = c("d", "f", "e", "c", "g", "b", "a")
    f1 = factor(fa)
    circos.initialize(factors = f1,xlim = c(0,1))
    #此事扇区顺序为d f e c g b a
    f2 = factor(fa,levels = fa)
    circos.initialize(factors = f2,xlim = c(0,1))
  }