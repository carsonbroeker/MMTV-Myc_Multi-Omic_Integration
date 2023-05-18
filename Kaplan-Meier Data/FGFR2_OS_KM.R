install.packages("survminer")
install.packages("dplyr")
library(dplyr)
library(survival)
library(survminer)
data = read.csv("FGFR2_OS_Data.csv")
s <- Surv(data$Time, data$Status)
sfit <- survfit(Surv(Time, Status)~Event, data=data)
ggsurvplot(sfit, data=data, surv.median.line = "hv", conf.int = FALSE, pval = TRUE, risk.table = TRUE,
           legend.labs=c("Amplified","Diploid"), legend.title="FGFR2 Status",
           palette = c("red","blue"), xlab="Time (Months)", ylab="Overall Survival Probability",
           title="Kaplan-Meier Curve for Overall Survival by FGFR2 Copy Number",
           risk.table.height=0.2, risk.table.y.text.col = TRUE, risk.table.y.text = FALSE, tables.theme = theme_cleantable())
fit <- surv_summary(sfit, data = data)
#res <- summary(fit,times=c(1,2))
save.df <- as.data.frame(fit[c("Event", "time", "n.risk", "n.event", "n.censor", "surv", "std.err", "lower", "upper")])
write.csv(save.df, file = "FGFR2_Amp_OS_Kmplot_Data.csv")
