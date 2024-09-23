import { ReactNode, createContext,
  useReducer,
  useCallback,
  useEffect,
  Children
 } from "react";
import { IAuthContext,IAuthContextAction,
  IAuthContextActionTypes,
  IAuthContextState,
  ILoginResponseDto
} from "../types/auth.types";
  
import { getSession, setSession } from "./auth.utils";
import axiosInstance from "../utils/axiosInstance";
import toast from 'react-hot-toast';
import { useNavigate } from "react-router-dom";
import { LOGIN_URL, 
  ME_URL, 
  PATH_AFTER_LOGIN, 
  PATH_AFTER_LOGOUT, 
  PATH_DASHBOARD,
  PATH_AFTER_REGISTER, 
  REGISTER_URL } from "../utils/globalConfig";

// We need a reducer function for useReducer hook
const authReducer = (state: IAuthContextState, action: IAuthContextAction) => {
  if(action.type === IAuthContextActionTypes.LOGIN){
    return { ...state, 
      isAuthenticated: true, 
      isAuthLoading: false, 
      user: action.payload 
    };
  }
  else if(action.type === IAuthContextActionTypes.LOGOUT){
    return { ...state, 
      isAuthenticated: false, 
      isAuthLoading: false,
      user: undefined
    };
  }
  return state;
};

//We need an initial store for UseReducer hook
const initialAuthState: IAuthContextState = {
  isAuthenticated: false,
  isAuthLoading: true,
  user: undefined
};
//we create our context here and export it
export const AuthContext = createContext<IAuthContext | null>(null);

//we need an interface for our context props
interface IProps {
  children: ReactNode;
};

//we create a component to manage all auth functionalities and export it and use it
const AuthContextProvider = ({children}: IProps) => {

  const [state, dispatch] = useReducer(authReducer, initialAuthState);
  const navigate = useNavigate();

  //Initial methods
  const initializeAuthContext = useCallback(async () => {
    try{
      const token = getSession();
      if(token){
        // validate access token by calling backend
        const response = await axiosInstance.post<ILoginResponseDto>(ME_URL, {
          token,
        });

        //In response, we receive jwt token and user data      
        const { newToken, userInfo } = response.data;
        setSession(newToken);
        dispatch({ 
          type: IAuthContextActionTypes.LOGIN, 
          payload: userInfo
        });
      }
      else{
        setSession(null);
        dispatch({ 
          type: IAuthContextActionTypes.LOGOUT 
        });
      }

    }catch(error){
      console.log('Error auth.Context.tsx->AuthContextProvider',error);
      setSession(null);
      dispatch({
        type: IAuthContextActionTypes.LOGOUT,
      });
    }
  }, []);

  //In star of application, we call initializeAuthContext to be sure about authentication status
  useEffect(() => {
    console.log("AuthContext Initialization start");
    initializeAuthContext()
    .then(() => console.log("Initialization was successful"))
    .catch((error) => console.log("Initialization failed", error));
    }, []);

    //Register Method
    const register= useCallback(
      async (firstName: string, lastName: string, userName: string, email: string, password: string, address: string) => {
        const response = await axiosInstance.post(REGISTER_URL, {
          firstName,
          lastName,
          userName,
          email,
          password,
          address
        });
        console.log("Register result:", response);
        toast.success("Register was successful. Please Login.");
        navigate(PATH_AFTER_REGISTER);
      }, []
    );

    //Login Method
    const login = useCallback(
      async (userName: string, password: string) => {
        const response = await axiosInstance.post<ILoginResponseDto>(LOGIN_URL, {
          userName,
          password
        });
        console.log("Login result:", response);
        toast.success("Login was successful.");

        //In response, we receive jwt token and user data
        const { newToken, userInfo } = response.data;
        setSession(newToken);
        dispatch({ 
          type: IAuthContextActionTypes.LOGIN, 
          payload: userInfo
        });
        navigate(PATH_AFTER_LOGIN);
      }, []);

      //Logout Method
    const logout = useCallback(async () => {
        setSession(null);
        dispatch({ 
          type: IAuthContextActionTypes.LOGOUT 
        });
        navigate(PATH_AFTER_LOGOUT);
      }, []);

      // We create an obj ect for values of context provider
      // this will keep our codes more readable
    const valuesObject = {
        isAuthenticated: state.isAuthenticated,
        isAuthLoading: state.isAuthLoading,
        user: state.user,
        register,
        login,
        logout,
      };

      return <AuthContext.Provider value={valuesObject}>{children}</AuthContext.Provider>;
};

export default AuthContextProvider;