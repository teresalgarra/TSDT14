[R_ld_av1, f_ld_av1] = averaging_low(y_ld);

figure;
subplot(2,1,1);
plot(f_ld_av1, R_ld_av1, 'b'); xlim([0,1]);
title('Averaged PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');

[R_ld_av2, f_ld_av2] = averaging_medium(y_ld);

figure;
subplot(2,1,1);
plot(f_ld_av2, R_ld_av2, 'b'); xlim([0,1]);
title('Averaged PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');

[R_ld_av3, f_ld_av3] = averaging_high(y_ld);

figure;
subplot(2,1,1);
plot(f_ld_av3, R_ld_av3, 'b'); xlim([0,1]);
title('Averaged PSD');
subplot(2,1,2);
plot(ff, R_ld_th, 'r'); xlim([0,1]);
title('Theoretical PSD');