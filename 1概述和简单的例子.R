#1 快速浏览
{
  #1 低级绘图函数和安排布局的函数
  {
    #低级绘图函数
    circos.points()#在单元格中添加点数。
    circos.lines()#在单元格中添加行。
    circos.segments()#在单元格中添加段。
    circos.rect()#在单元格中添加矩形。
    circos.polygon()#在单元格中添加多边形。
    circos.text()#在单元格中添加文本。
    circos.axis();circos.yaxis()#在单元格中添加轴。
    
    #安排布局的函数(高级函数)
    circos.initialize()   #在圈子上分配扇区。
    circos.track()    #为单个轨道中的单元格创建绘图区域。
    circos.update()   #更新现有单元格。
    circos.par()     #图形参数。
    circos.info()    #打印当前圆形图的一般参数。
    circos.clear()    #重置图形参数和内部变量。
  }
  
  #2 一个简单的例子
  {
    #生成数据
    {
      set.seed(999)
      n = 1000
      df = data.frame(factor = sample(letters[1:8],n,replace = T),
                      x = rnorm(n),
                      y = runif(n))
    }
    
    #初始化布局
    {
      #circos默认圆的半径为1，0.1表示分为十份
      circos.par("track.height" = 0.1) #轨道高度为0.1
      circos.initialize(factors = df$factor,#按照factors拆分为扇区
                        x = df$x)           #按照factor对应的x计算扇区宽度
    }
    
    #绘制第一条轨道
    {
      #circos.track为逐个单元格绘制第一条轨道
      #CELL_META是当前单元格的所有信息
      #panel.fun是创建一个单元格就对创建的单元格执行一次
      circos.track(factors = df$factor, y = df$y, #指定factors和y轴,因为x轴init过了
                   panel.fun = function(x, y) {   #构造方法？？
                     circos.text(CELL_META$xcenter, CELL_META$cell.ylim[2] + 2, 
                                 CELL_META$sector.index) #在圈外绘制字母
                     circos.axis(labels.cex = 0.6) #指定坐标轴刻度大小
                   })
      col = rep(c('red','green'),4)
      circos.trackPoints(df$factor,df$x,df$y,col = col,
                         pch = 16,cex = 0.5)   #整条轨道绘制散点
      #特定位置绘制文本,外部使用时必须指定sector和track
      circos.text(-1,0.5,"text",sector.index = 'a',track.index = 1)
    }
    
    #绘制第二条轨道
    {
      #高级函数画轨道,低级函数轨道上添加东西,trackHist是一个高级函数
      bgcol = rep(c("white",'grey'),4)
      circos.trackHist(df$factor,df$x,bin.size = 0.2,bg.col = bgcol,col = NA)
    }
    
    #绘制第三条轨道
    {
      #当.track函数指定了x和y，xy会作为参数传进panel.fun
      circos.track(factors = df$factor,x = df$x,y = df$y,
                   panel.fun = function(x,y)
                     {
                     circos.lines(x = x[1:10],y = y[1:10])
                     })
      
    }
    
    #更新单元格
    {
      #清空指定单元格并把当前单元格定位到清空的单元格
      circos.update(sector.index = 'a',track.index = 2,
                    bg.col = '#FF8080')
      #将当前单元格进行内容修改
      circos.text(CELL_META$xcenter,CELL_META$ycenter,
                  'Happy',col = 'white')
    }
    
    #绘制第四条轨道并绘制热图
    {
      circos.track(ylim = c(0,1),panel.fun = function(x,y)
      {
        xlim = CELL_META$xlim 
        ylim = CELL_META$ylim
        breaks = seq(xlim[1],xlim[2],by =0.1)
        n_breaks = length(breaks)
        #绘制热图
        circos.rect(breaks[-n_breaks], 
                    rep(ylim[1], n_breaks - 1),
                    breaks[-1], rep(ylim[2], n_breaks - 1),
                    col = rand_color(n_breaks), border = NA)
      })
      
    }
    
    #绘制轨道之间的连接
    {
      circos.link("a",0,'b',0,h = 0.2)
      circos.link('b',c(0,2),'e',c(-0.5,1.5),col = 'blue',h = 0.4)
      circos.link('f',0,'h',c(-0.5,2),border = 'black',
                  lty = 3,lwd = 1.5)
    } 
    
    #最后,清空
    circos.clear()
  }
}