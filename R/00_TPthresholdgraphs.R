# # must run CDMO script first for appropriate .csv file
# # if you need file uncomment line below
# source('R/02_Load_Wrangle_Run_PlotsSummaryCDMO.R')

# -----------------------------------------------
# TP plots
# -----------------------------------------------

# pine island
ggplot(data=pi_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.105, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.105, ymax=0.2, fill='Poor'))+
  geom_hline(yintercept = 0.105, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=TP), color='black', size=1) +
  geom_point(aes(x=date, y=TP), color='black', size=3) +
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
  labs(x='', y='Total Phosphorus (mg/L)',
       title='Pine Island')
ggsave("output/PI_TP.png", dpi = 300)

# san sebastian
ggplot(data=ss_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.11, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.11, ymax=0.2, fill='Poor'))+
  geom_hline(yintercept = 0.11, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=TP), color='black', size=1) +
  geom_point(aes(x=date, y=TP), color='black', size=3) +
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
  labs(x='', y="Total Phosphorus (mg/L)",
       title='San Sebastian')
ggsave('output/SS_TP.png', dpi = 300)

# fort matanzas
ggplot(data=fm_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.111, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.111, ymax=0.2, fill='Poor'))+
  geom_hline(yintercept = 0.111, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=TP), color='black', size=1) +
  geom_point(aes(x=date, y=TP), color='black', size=3) +
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
  labs(x='', y="Total Phosphorus (mg/L)",
       title='Fort Matanzas')
ggsave('output/FM_TP.png', dpi = 300)

# pellicer creek grab
ggplot(data=pc_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.123, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.123, ymax=0.25, fill='Poor'))+
  geom_hline(yintercept = 0.123, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=TP), color='black', size=1) +
  geom_point(aes(x=date, y=TP), color='black', size=3) +
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
  labs(x='', y="Total Phosphorus (mg/L)",
       title='Pellicer Creek')
ggsave('output/PC_TP.png', dpi = 300)

# pellicer creek ISCO
ggplot(data=pcISCO_dat)+
  geom_ribbon(aes(x=datetimestamp, ymin=0, ymax=0.123, fill='Good'))+
  geom_ribbon(aes(x=datetimestamp, ymin=0.123, ymax=0.25, fill='Poor'))+
  geom_hline(yintercept = 0.123, linetype='longdash', color = 'gray18', size=2)+
  geom_point(aes(x=datetimestamp, y=total.p1), color='black', size=3) +
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
  labs(x='', y="Total Phosphorus (mg/L)",
       title='Pellicer Creek ISCO')
ggsave('output/PCISCO_TP.png', dpi = 300)
