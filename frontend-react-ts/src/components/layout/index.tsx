import useAuth from "../../hooks/useAuth.hook";
import Header from "./header";
import { Outlet, useLocation } from "react-router-dom";
import Sidebar from "./Sidebar";


const Layout = () => {
  const { isAuthenticated } = useAuth();
  const { pathname } = useLocation();

  console.log(pathname);

  const sideBarRendered = () => {
    if (isAuthenticated && pathname.toLocaleLowerCase().startsWith("/dashboard")) {
      return <Sidebar />
    }
    return null;
  };

  return <div>
    <Header />
    { //using Outlet, we render all routers that are inside of this Layout */
      <div className="flex">
        {sideBarRendered()}
        <Outlet />
      </div>
    }
  </div>
};

export default Layout;