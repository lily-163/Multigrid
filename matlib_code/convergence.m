%% 64
% i = 1:1:1504;
% figure(1);
% plot(i,r64,'g',i(30:360),rV64,'b',i(1:81),rC64,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([1,1504,0,0.01]);

%% 32
% i = 1:1:434;
% figure(2);
% plot(i,r32,'g',i(20:252),rV32,'b',i(1:172),rC32,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([1,434,0,0.01]);

%% 16
% i = 1:1:63;
% figure(3)
% plot(i,r16,'g',i(12:60),rV16,'b',i(1:48),rC16,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([1,63,0,0.01]);

%% 8
% i = 1:1:49;
% figure(4)
% plot(i(1:40),r8,'g',i(12:49),rV8,'b',i(1:40),rC8,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([0,49,0,0.01]);


% 
% U1 = UC64 - U(1:2:end,1:2:end);
% norm(abs(U1(:)),'inf')


%% 64
% i = 1:1:372;
% plot(i,r64,'g',i(285:338),rV64,'b',i(1:44),rC64,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% xlabel('iter');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([0,372,0,0.01]);

%% 32
% i = 1:1:215;
% plot(i,r32,'g',i(120:186),rV32,'b',i(1:52),rC32,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% xlabel('iter');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([0,372,0,0.01]);

%% 16
% i = 1:1:80;
% plot(i(1:55),r16,'g',i(42:80),rV16,'b',i(1:40),rC16,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% xlabel('iter');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([0,80,0,0.01]);

%% 8
% i = 1:1:50;
% plot(i(1:34),r8,'g',i(21:50),rV8,'b',i(1:31),rC8,'r');
% legend('ÄâÅ£¶Ù','V\_Cycle','CMG');
% xlabel('iter');
% ylabel('||u_{n+1}-u_n||_{\infty}');
% axis([0,50,0,0.01]);
