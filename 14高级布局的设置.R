#install.packages('circlize')
#install.packages('reshape')
#install.packages('dendextend')

library(reshape)
library(circlize)

#都是进化树用的
library(ape)  #数据集包
library(dendextend)  #进化树美化

#6 高级布局 
{
  #6.1 介绍如何缩放扇区并将缩放的扇区放在与原始扇区相同的轨道上
  {
    #生成数据df2
    {
      #生成初始数据
      set.seed(123)
      df = data.frame(
        factors = sample(letters[1:6], 400, replace = TRUE),
        x = rnorm(400),
        y = rnorm(400),
        stringsAsFactors = FALSE
      )
      #取前a和b的前十个点
      zoom_df_a = df[df$factors == "a", ]
      zoom_df_b = df[df$factors == "b", ]
      zoom_df_b = zoom_df_b[order(zoom_df_b[, 2])[1:10], ]
      zoom_df = rbind(zoom_df_a, zoom_df_b)
      #重新绑定到新的数据框
      zoom_df$factors = paste0("zoom_", zoom_df$factors)
      df2 = rbind(df, zoom_df)
    }
    
    #计算每个区域大小
    #圆的整个sector.width = 2
    {
      #tapply传入两个等长的变量,按照第二个向量分类,按照第三个函数计算每个类别的结果
      #此处求出所有类别的最大最小值的差
      xrange = tapply(df2$x, df2$factors, function(x) max(x) - min(x))
      #指定宽度
      normal_sector_index = unique(df$factors)
      zoomed_sector_index = unique(zoom_df$factors)
      #计算每个类别应该对应的区域大小
      sector.width = c(xrange[normal_sector_index] / sum(xrange[normal_sector_index]), 
                       xrange[zoomed_sector_index] / sum(xrange[zoomed_sector_index]))
      sector.width
      sum(sector.width)
    }
    
    #画图
    {
      circos.par(start.degree = 90, points.overflow.warning = FALSE)
      circos.initialize(df2$factors, x = df2$x, sector.width = sector.width)
      circos.track(df2$factors, x = df2$x, y = df2$y, 
                   panel.fun = function(x, y) {
                     circos.points(x, y, col = "red", pch = 16, cex = 0.5)
                     circos.text(CELL_META$xcenter, CELL_META$cell.ylim[2] + uy(2, "mm"), 
                                 CELL_META$sector.index, niceFacing = TRUE)
                   })
    }
    
    #添加链接
    {
      circos.link("a", get.cell.meta.data("cell.xlim", sector.index = "a"),
                  "zoom_a", get.cell.meta.data("cell.xlim", sector.index = "zoom_a"),
                  border = NA, col = "#00000020")
      circos.link("b", c(zoom_df_b[1, 2], zoom_df_b[10, 2]),
                  "zoom_b", get.cell.meta.data("cell.xlim", sector.index = "zoom_b"),
                  rou1 = get.cell.meta.data("cell.top.radius", sector.index = "b"),
                  border = NA, col = "yellow")
    }
    
    circos.clear()
  }
  
  #6.2 绘制圆的一部分
  {
    #使用基础参数只绘制四分之一圆  .par法
    {
      #利用canvas参数限定画出来的地方
      circos.par("canvas.xlim" = c(0, 1), "canvas.ylim" = c(0, 1),
                 "start.degree" = 90, "gap.after" = 270)
      factors = "a" 
      circos.initialize(factors = factors, xlim = c(0,1))
      circos.track(ylim = c(0,1))
    }
    
    #使用.update函数绘制
    {
      #初始化一个整个的轨道
      factors = letters[1:4]
      circos.initialize(factors = factors, xlim = c(0, 1))
      
      # 用其他数据绘制四分之一
      df = data.frame(factors = rep("a", 100),
                      x = runif(100),
                      y = runif(100))
      circos.track(df$factors, x = df$x, y = df$y, 
                   panel.fun = function(x, y) {
                     circos.points(x, y, pch = 16, cex = 0.5)
                   })
      
      # 创建空轨道,然后更新并绘制单个区域
      circos.track(ylim = range(df$y), bg.border = NA)
      circos.update(sector.index = "a", bg.border = "black")
      circos.points(df$x, df$y, pch = 16, cex = 0.5)
      #再次创建两个轨道
      circos.track(factors = factors, ylim = c(0, 1))
      circos.track(factors = factors, ylim = c(0, 1))
    }
    circos.clear()
  }
  
  #6.3 组合多个圆形图  par(new = T)
  {
    # 绘制多个环
    {
      factors = letters[1:4]
      circos.initialize(factors = factors, xlim = c(0, 1))
      circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
        circos.text(0.5, 0.5, "outer circos", niceFacing = TRUE)
      })
      circos.clear()
      
      par(new = TRUE) # <- magic
      circos.par("canvas.xlim" = c(-3, 3), "canvas.ylim" = c(-3, 3))
      factors = letters[1:3]
      circos.initialize(factors = factors, xlim = c(0, 1))
      circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
        circos.text(0.5, 0.5, "inner circos", niceFacing = TRUE)
      })
      circos.clear()
    }
    
    # 绘制四个断环并组合在一起
    {
      factors = letters[1:4]
      lim = c(1, 1.1, 1.2, 1.3)
      for(i in 1:4) {
        circos.par("canvas.xlim" = c(-lim[i], lim[i]), 
                   "canvas.ylim" = c(-lim[i], lim[i]), 
                   "track.height" = 0.4)
        circos.initialize(factors = factors, xlim = c(0, 1))
        circos.track(ylim = c(0, 1), bg.border = NA)
        circos.update(sector.index = factors[i], bg.border = "black")
        circos.points(runif(10), runif(10), pch = 16)
        circos.clear()
        par(new = TRUE)
      }
      par(new = FALSE)
    }
    
  }
  
  #6.4 同时绘制更多的圈图
  {
    #使用layout函数,画出9个circle,3 * 3排列
    layout(matrix(1:9, 3, 3))
    for(i in 1:9) {
      factors = 1:8
      par(mar = c(0.5, 0.5, 0.5, 0.5))
      circos.par(cell.padding = c(0, 0, 0, 0))
      circos.initialize(factors, xlim = c(0, 1))
      circos.track(ylim = c(0, 1), track.height = 0.05,
                   bg.col = rand_color(8), bg.border = NA)
      #绘制链接
      for(i in 1:20) {
        se = sample(1:8, 2)
        circos.link(se[1], runif(2), se[2], runif(2), 
                    col = rand_color(1, transparency = 0.4), border = NA)
      }
      circos.clear()
    }
    
  }
  
}