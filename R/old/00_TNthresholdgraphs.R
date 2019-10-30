# # must run CDMO script first for appropriate .csv file
# # if you need file uncomment line below
# source('R/02_Load_Wrangle_Run_PlotsSummaryCDMO.R')

# -----------------------------------------------
# TN plots
# -----------------------------------------------

# pine island
ggplot(data=pi_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.65, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.65, ymax=1.0, fill='Poor'))+
  geom_hline(yintercept = 0.65, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=TN), color='black', size=1) +
  geom_point(aes(x=date, y=TN), color='black', size=3) +
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
  labs(x='', y='Total Nitrogen (mg/L)',
       title='Pine Island')
ggsave("output/PI_TN.png", dpi = 300)

# san sebastian
ggplot(data=ss_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.55, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.55, ymax=1.0, fill='Poor'))+
  geom_hline(yintercept = 0.55, linetype='longdash', color = 'gray18', size=1.5)+
  geom_line(aes(x=date, y=TN), color='black', size=1) +
  geom_point(aes(x=date, y=TN), color='black', size=3) +
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
  labs(x='', y="Total Nitrogen (mg/L)",
       title='San Sebastian')
ggsave('output/SS_TN.png', dpi = 300)

# fort matanzas
ggplot(data=fm_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=0.53, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=0.53, ymax=1.0, fill='Poor'))+
  geom_hline(yintercept = 0.53, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=TN), color='black', size=1) +
  geom_point(aes(x=date, y=TN), color='black', size=3) +
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
  labs(x='', y="Total Nitrogen (mg/L)",
       title='Fort Matanzas')
ggsave('output/FM_TN.png', dpi = 300)

# pellicer creek grab
ggplot(data=pc_df)+
  geom_ribbon(aes(x=date, ymin=0, ymax=1.10, fill='Good'))+
  geom_ribbon(aes(x=date, ymin=1.10, ymax=2, fill='Poor'))+
  geom_hline(yintercept = 1.10, linetype='longdash', color = 'gray18', size=2)+
  geom_line(aes(x=date, y=TN), color='black', size=1) +
  geom_point(aes(x=date, y=TN), color='black', size=3) +
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
  labs(x='', y="Total Nitrogen (mg/L)",
       title='Pellicer Creek')
ggsave('output/PC_TN.png', dpi = 300)


# for pc, we'll have to calculate tn in the "large" dataframe
pcISCO_dat$TN <- pcISCO_dat$kjeldahl.nitrogen1 + pcISCO_dat$no2no3.n1

# pellicer creek ISCO
ggplot(data=pcISCO_dat)+
  geom_ribbon(aes(x=datetimestamp, ymin=0, ymax=1.1, fill='Good'))+
  geom_ribbon(aes(x=datetimestamp, ymin=1.1, ymax=2, fill='Poor'))+
  geom_hline(yintercept = 1.1, linetype='longdash', color = 'gray18', size=2)+
  geom_point(aes(x=datetimestamp, y=TN), color='black', size=3) +
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
  labs(x='', y="Total Nitrogen (mg/L)",
       title='Pellicer Creek ISCO')
ggsave('output/PCISCO_TN.png', dpi = 300)
