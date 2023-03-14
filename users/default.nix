let
  mkUser = { username, admin ? false, normalUser ? false, ssh ? [ ] }: {
    inherit username admin normalUser ssh;
    config = if normalUser then (import ./${username}) else { ... }: { };
  };
in {
  paulwalker = mkUser {
    username = "paulwalker";
    admin = true;
    normalUser = true;
    ssh = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK1ZKaSnmZNZmvf9kmKaO/6SyaBV2gC11/Cre9RUDnER"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7DXKJns7+SW4Vff4R8TofQP2ReyyHy9iVH+ybFgE24"
    ];
  };
  owen = mkUser {
    username = "owen";
    admin = true;
    ssh = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCNT9b7WeeRwjiXmwAkdLeLeM1/XTdJgnqCwPExUvUno73gcUn828hLcCElhhSfxcHMNpC140Yc5j+Nfb1VKkyR0MnJSkXLi/XE6uSglouKGQbUr5CFRYUiTHg/MmvLHvgt6qIsJCXIhYz3lDAkA/T/eOwdBiCEzNRW7vcmllYQkX0HoUuytnVwf9HSOCY88qwOGKcczpmVGBL4G/bEjuxtfgijdPh8Ybqr/e1TxZTOBNyNQiTVcBb8o+7Wis+O9KhN3vRjDiguW6FWn9t8x5jfRbe9jX1DLvOVkWOR5vJ4ZFnBTXI3+Nl8TVYJrMoZ01jj28vyNNYUcyKYDGx1FPzHf2e6O4nhQGFGdMFBMsg8zGkLKbPuP9IkmqYcK4ccOUAu3HuiGHSHKjIfjw3rZVvJ28RrXSIrqEFEX6l50+0mrBZGgmLFg2z2+nmF1ns0coOI00/YSeBmFDGuhngmHXqi/GD5pq/Kje8ldQO1MaS61UINcR6QuCgk1vxD9zlEOg8="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoHdSzQ8ju1D3EAjz4SeOPT0RYwmJSoIasklNUQ344H1IstADAG7Zu7kM+HUKKEgkRiF+k026DNuZUhUPKiZ/DbrLljZf6pMeDlFCkKZw4UC4wBsh+B3Rf5k0Kte0fskbj5wAKHoyb1irxqCz/ficHEJDfP1VE/5Xw/v45498TfI7V8VyNcIaWORG8NN+4l1byk9ytYVXSxrtUN6eXmeWNC7oGJHKsL/nrR1/JYngzF2r0RPvAomXtpiKhx0e4VX1Y6ZsS15Xtz9Gel98/q7QMTY3Osv4VUS/MrHtDNAyWX4RtdVyLarQRhWRYCwU16mPV/CKVhLOE3C2DgHXyvoGGyLe4xOzbHhNRWy9QgsVDAly9gl3AhRCjix3/rYgkzv4a8PbT389rbBeo+RtPeu/s8qyQlgbcBokuPG+IaEA8ztgIf11V4l+ja1vvYLw8/sAhXr4qcnmowNd3Zo8RtAJLrt9Otw2Wdat6pnWDT9ZWEJdt8W6u3FRs7BwqokJEHXM="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCaTjpweHnGX+n5UbY+VtGj5iTUJhEv8GyYmOJimUgEj2q5Ztco7TZ9vPYCioJ6Ufju8NLlLysKzDMYyHK8wAS35C1uB5jvxQsFtpmZzLYZvQfJBNokIE8hZAtfyyJk4ZmsmFcpU+b3VJejPEwIlKDEdHVp+RuylJ751CI1MRab4Ze0aNd/QrF7FdGjncD2IUI8j8TNxaAfvNAxNpkJKVpuIhkJ/xeAhbbFySwkoKSO1qppJs57TOyVV60aRGtGx+v/asJLz2fHrrGdnpKaNsYQw97I5zMZzWQqVxRyjqYaSIsY41lxuLrG1zE8yyU2+HCLnX8wQYI5PW4nqmedwb+cEsv+I7m7FLPKd1h7JW24ijmzlJ15tYzr+EMbdTL7ZLkzCc0Jr/GTfE4pfhh6pRJMVFdBOcleIMj1S71MKD2gAaMbGCwErlQzAisJAskYPQwdvOlOrEpzGHS9fn9UHhEJfsDeC32hWYQZIJ9Bm57uJ5mzj9a1ciJIpg8CW9St8ks="
    ];
  };
}
