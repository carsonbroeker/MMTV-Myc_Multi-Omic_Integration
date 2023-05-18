library(dplyr)
library(survival)
library(survminer)
data = read.csv("KRAS_OS_Data.csv")
s <- Surv(data$Time, data$Status)
sfit <- survfit(Surv(Time, Status)~Event, data=data)
ggsurvplot(sfit, data=data, surv.median.line = "hv", conf.int = TRUE, pval = TRUE, risk.table = TRUE,
           legend.labs=c("KRAS Amplified or\nActivating Mutation","Unaltered"), legend.title="Alteration Status",
           palette = c("red","blue"), xlab="Time (Months)", ylab="Overall Survival Probability",
           title="Kaplan-Meier Curve for Overall Survival by KRAS Alteration Status",
           risk.table.height=0.2, risk.table.y.text.col = TRUE, risk.table.y.text = FALSE,
           tables.theme = theme_cleantable())
fit <- surv_summary(sfit, data = data)
#res <- summary(sfit,times=c(1,2))
save.df <- as.data.frame(fit[c("Event", "time", "n.risk", "n.event", "surv", "std.err", "lower", "upper")])
write.csv(save.df, file = "KRAS_OS_Kmplot_Data.csv")
