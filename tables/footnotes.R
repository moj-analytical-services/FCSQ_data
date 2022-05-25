# notes
notes_select <- function(notes, table){
  notes %>% filter(`Table number` == table) %>% 
    pull(`Note text`)
}

t1_notes <- notes_select(notes_import, 'Table 1')
t2_notes <-  notes_select(notes_import, 'Table 2')
t3_notes <- notes_select(notes_import, 'Table 3')
t4_notes <- notes_select(notes_import, 'Table 4')
t5_notes <- notes_select(notes_import, 'Table 5')
t6_notes <- notes_select(notes_import, 'Table 6')
t7_notes <- notes_select(notes_import, 'Table 7')
t8_notes <- notes_select(notes_import, 'Table 8')
t9_notes <- notes_select(notes_import, 'Table 9')
t10_notes <- notes_select(notes_import, 'Table 10')
t11_notes <- notes_select(notes_import, 'Table 11')
t12_notes <- notes_select(notes_import, 'Table 12')
t13_notes <- notes_select(notes_import, 'Table 13')
t14_notes <- notes_select(notes_import, 'Table 14')
t15_notes <- notes_select(notes_import, 'Table 15')
t16_notes <- notes_select(notes_import, 'Table 16')
t17_notes <- notes_select(notes_import, 'Table 17')
t18_notes <- notes_select(notes_import, 'Table 18')
t19_notes <- notes_select(notes_import, 'Table 19')
t20_notes <- notes_select(notes_import, 'Table 20')
t21_notes <- notes_select(notes_import, 'Table 21')
t22_notes <- notes_select(notes_import, 'Table 22')
t23_notes <- notes_select(notes_import, 'Table 23')
t24_notes <- notes_select(notes_import, 'Table 24')
t25_notes <- notes_select(notes_import, 'Table 25')

# notes added to regular tables

notes1 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
            glue("{seq_along(t1_notes)}) {t1_notes}"))


notes2 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
            glue("{seq_along(t2_notes)}) {t2_notes}"))

notes3 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t3_notes)}) {t3_notes}"))

notes4 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t4_notes)}) {t4_notes}"))

notes5 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
            glue("{seq_along(t5_notes)}) {t5_notes}"))

notes6 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t6_notes)}) {t6_notes}"))

notes7 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t7_notes)}) {t7_notes}"))

notes8 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t8_notes)}) {t8_notes}"))

notes9 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t9_notes)}) {t9_notes}"))

notes10 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t10_notes)}) {t10_notes}"))

notes11 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t11_notes)}) {t11_notes}"))

notes12 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t12_notes)}) {t12_notes}"))

notes13 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t13_notes)}) {t13_notes}"))

notes14 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t14_notes)}) {t14_notes}"))


notes15 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t15_notes)}) {t15_notes}"))

notes16 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t16_notes)}) {t16_notes}"))

notes17 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t17_notes)}) {t17_notes}"))

notes18 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t18_notes)}) {t18_notes}"))

notes19 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t19_notes)}) {t19_notes}"))

notes20 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t20_notes)}) {t20_notes}"))

notes21 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t21_notes)}) {t21_notes}"))

notes22 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t22_notes)}) {t22_notes}"))

notes23 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t23_notes)}) {t23_notes}"))

notes24 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t24_notes)}) {t24_notes}"))

notes25 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t25_notes)}) {t25_notes}"))