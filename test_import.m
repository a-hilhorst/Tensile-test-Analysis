%% test from xlsx
clear
data_xls1 = import_from_xlsx('E:/_Tools/Tensile-test-analysis/imap_versions/sophie dr/Traction-1.XLSX');
data_xls2 = import_from_xlsx('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\Traction-4_316.xlsx'); % attention
data_xls3 = import_from_xlsx('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\TWIP 10 mmmin.xls'); % attention
data_xls4 = import_from_xlsx('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\TWIP-2.xls'); % attention
data_xls5 = import_from_xlsx('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\chargé_gaz.xls');

%% test from tra
% clear
% data_tra1 = import_from_txt('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\Allong 1.TRA', 'tra2txt', true);
% data_tra2 = import_from_txt('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\mDB1pct.TRA', 'tra2txt', true);
% data_tra3 = import_from_txt('E:\_Tools\Tensile-test-analysis\imap_versions\other_machine_outputs_examples\Invar_LT_05_01.TRA', 'tra2txt', true);