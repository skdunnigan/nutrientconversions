# # must run CDMO script first for appropriate .csv file
# # if you need file uncomment line below
# source('R/02_Load_Wrangle_Run_PlotsSummaryCDMO.R')

# -----------------------------------------------
# TP plots
# -----------------------------------------------

# pine island
ggplot(data=pi_df)+
  geom_line(aes(x=date, y=Fecal), color='black', size=1) +
  geom_point(aes(x=date, y=Fecal), color='black', size=3) +
  theme_classic()+
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y='Fecal coliforms (CFU/100mL)',
       title='Pine Island')
ggsave("output/PI_Fecal.png", dpi = 300)

# san sebastian
ggplot(data=ss_df)+
  geom_line(aes(x=date, y=Fecal), color='black', size=1) +
  geom_point(aes(x=date, y=Fecal), color='black', size=3) +
  theme_classic()+
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y="Fecal coliforms (CFU/100mL)",
       title='San Sebastian')
ggsave('output/SS_Fecal.png', dpi = 300)

# fort matanzas
ggplot(data=fm_df)+
  geom_line(aes(x=date, y=Fecal), color='black', size=1) +
  geom_point(aes(x=date, y=Fecal), color='black', size=3) +
  theme_classic()+
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y="Fecal coliforms (CFU/100mL)",
       title='Fort Matanzas')
ggsave('output/FM_Fecal.png', dpi = 300)

# pellicer creek grab
ggplot(data=pc_df)+
  geom_line(aes(x=date, y=Fecal), color='black', size=1) +
  geom_point(aes(x=date, y=Fecal), color='black', size=3) +
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y="Fecal coliforms (CFU/100mL)",
       title='Pellicer Creek')
ggsave('output/PC_Fecal.png', dpi = 300)

# pellicer creek ISCO
ggplot(data=pcISCO_dat)+
  geom_point(aes(x=datetimestamp, y=fecal.coliforms.membrane.filter1), color='black', size=3) +
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y="Fecal coliforms (CFU/100mL)",
       title='Pellicer Creek ISCO')
ggsave('output/PCISCO_Fecal.png', dpi = 300)

# -----------------------------------------------------
# pellicer creek grab for ecoli
# -----------------------------------------------------
# create label for plot
ecoli_y_title <- expression(paste(italic("Escherichia coli"), " CFU/100mL"))
# filter dataset since the Ecoli sample is only taken in gtmpcnut1.1
ecoli_dat <- pc_dat %>%
  filter(monitoringprogram =="1", replicate == "1")

ggplot(data=ecoli_dat)+
  geom_point(aes(x=datetimestamp, y=escherichia.coli.quanti.tray1), size=3)+
  geom_line(aes(x=datetimestamp, y=escherichia.coli.quanti.tray1), size=1) +
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
  # scale_y_continuous(expand = c(0,0))+
  scale_x_datetime(date_breaks = '1 month', date_minor_breaks = '2 weeks', date_labels='%b')+
  labs(x='', y=ecoli_y_title,
       title='Pellicer Creek')
ggsave('output/PC_Ecoli.png', dpi = 300)