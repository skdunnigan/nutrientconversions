# -----------------------------------------------
# create chlorophyll plot
# -----------------------------------------------

# # must run CDMO script first for appropriate .csv file
# # if you need file uncomment line below
# source('R/02_Load_Wrangle_Run_PlotsSummaryCDMO.R')

# -----------------------------------------------
# plots
# -----------------------------------------------
# create label for chlorophyll plot
chla_y_title <- expression(paste("Chlorophyll ", italic("a "), mu*"g/L"))
# pine island
ggplot(data=pi_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=6.6, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=6.6, ymax=15, fill='Poor'))+
  geom_hline(yintercept = 6.6, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=CHLA), color='black', size=1) +
  geom_point(aes(x=date, y=CHLA), color='black', size=3) +
  theme_classic()+
  scale_fill_manual(name='', values=c('Good' = '#B4EEB4', 'Poor' = '#FEC596'))+
  theme(legend.title = element_blank(),  # everything in theme is strictly aesthetics
        legend.position = "bottom",
        legend.text = element_text(size=12),
        axis.title.x = element_blank(),
        axis.title.y=element_text(size=13),
        axis.ticks = element_line(color='black'),
        plot.caption = element_text(size=6, face='italic'),
        axis.text.x = element_text(angle = 90, vjust=0.3, size=12, color='black'),
        axis.text.y = element_text(size=12, color='black'),
        axis.ticks.x=element_line(color='black'),
        title = element_text(size = 13, face='bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color='gray95'))+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=chla_y_title,
       title='Pine Island')
ggsave("output/PI_Chla.png", dpi = 300)

# san sebastian
ggplot(data=ss_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=4.0, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=4.0, ymax=15, fill='Poor'))+
  geom_hline(yintercept = 4.0, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=CHLA), color='black', size=1) +
  geom_point(aes(x=date, y=CHLA), color='black', size=3) +
  theme_classic()+
  scale_fill_manual(name='', values=c('Good' = '#B4EEB4', 'Poor' = '#FEC596'))+
  theme(legend.title = element_blank(),  # everything in theme is strictly aesthetics
        legend.position = "bottom",
        legend.text = element_text(size=12),
        axis.title.x = element_blank(),
        axis.title.y=element_text(size=13),
        axis.ticks = element_line(color='black'),
        plot.caption = element_text(size=6, face='italic'),
        axis.text.x = element_text(angle = 90, vjust=0.3, size=12, color='black'),
        axis.text.y = element_text(size=12, color='black'),
        axis.ticks.x=element_line(color='black'),
        title = element_text(size = 13, face='bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color='gray95'))+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=chla_y_title,
       title='San Sebastian')
ggsave('output/SS_Chla.png', dpi = 300)

# fort matanzas
ggplot(data=fm_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=5.5, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=5.5, ymax=15, fill='Poor'))+
  geom_hline(yintercept = 5.5, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=CHLA), color='black', size=1) +
  geom_point(aes(x=date, y=CHLA), color='black', size=3) +
  theme_classic()+
  scale_fill_manual(name='', values=c('Good' = '#B4EEB4', 'Poor' = '#FEC596'))+
  theme(legend.title = element_blank(),  # everything in theme is strictly aesthetics
        legend.position = "bottom",
        legend.text = element_text(size=12),
        axis.title.x = element_blank(),
        axis.title.y=element_text(size=13),
        axis.ticks = element_line(color='black'),
        plot.caption = element_text(size=6, face='italic'),
        axis.text.x = element_text(angle = 90, vjust=0.3, size=12, color='black'),
        axis.text.y = element_text(size=12, color='black'),
        axis.ticks.x=element_line(color='black'),
        title = element_text(size = 13, face='bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color='gray95'))+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=chla_y_title,
       title='Fort Matanzas')
ggsave('output/FM_Chla.png', dpi = 300)

# pellicer creek grab
ggplot(data=pc_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=4.3, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=4.3, ymax=30, fill='Poor'))+
  geom_hline(yintercept = 4.3, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=CHLA), color='black', size=1) +
  geom_point(aes(x=date, y=CHLA), color='black', size=3) +
  geom_point(data=pc_dat, aes(x=datetimestamp, y=chlorophyll.a..corrected2), color='gray50', size=3) +
  theme_classic()+
  scale_fill_manual(name='', values=c('Good' = '#B4EEB4', 'Poor' = '#FEC596'))+
  theme(legend.title = element_blank(),  # everything in theme is strictly aesthetics
        legend.position = "bottom",
        legend.text = element_text(size=12),
        axis.title.x = element_blank(),
        axis.title.y=element_text(size=13),
        axis.ticks = element_line(color='black'),
        plot.caption = element_text(size=6, face='italic'),
        axis.text.x = element_text(angle = 90, vjust=0.3, size=12, color='black'),
        axis.text.y = element_text(size=12, color='black'),
        axis.ticks.x=element_line(color='black'),
        title = element_text(size = 13, face='bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color='gray95'))+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=chla_y_title,
       title='Pellicer Creek', caption = '*Gray data points are the duplicate chlorophyll sample taken at gtmpcnut1.1')
ggsave('output/PC_Chla.png', dpi = 300)

# pellicer creek ISCO
ggplot(data=pcISCO_dat)+
  geom_ribbon(aes(x=datetimestamp, ymin=0, ymax=4.3, fill='Good'))+
  geom_ribbon(aes(x=datetimestamp, ymin=4.3, ymax=40, fill='Poor'))+
  geom_hline(yintercept = 4.3, linetype='longdash', color = 'gray18', size=2)+
  geom_point(aes(x=datetimestamp, y=chlorophyll.a..corrected1), color='black', size=3) +
  theme_classic()+
  scale_fill_manual(name='', values=c('Good' = '#B4EEB4', 'Poor' = '#FEC596'))+
  theme(legend.title = element_blank(),  # everything in theme is strictly aesthetics
        legend.position = "bottom",
        legend.text = element_text(size=12),
        axis.title.x = element_blank(),
        axis.title.y=element_text(size=13),
        axis.ticks = element_line(color='black'),
        plot.caption = element_text(size=6, face='italic'),
        axis.text.x = element_text(angle = 90, vjust=0.3, size=12, color='black'),
        axis.text.y = element_text(size=12, color='black'),
        axis.ticks.x=element_line(color='black'),
        title = element_text(size = 13, face='bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color='gray95'))+
  scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=chla_y_title,
       title='Pellicer Creek ISCO')
ggsave('output/PCISCO_Chla.png', dpi = 300)
